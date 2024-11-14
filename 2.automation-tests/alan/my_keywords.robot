*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    RequestsLibrary
Library    myenv/lib/python3.12/site-packages/robot/libraries/String.py

*** Variables ***
###### URL onde e possivel verificar os horarios disponiveis
${horarios_disponiveis}    https://components-legacy.feegow.com/index.php/agendamento-online/client/minhaclinica/filter-schedule?PorEspecialidade=
###### Lista com as opcoes de consulta para agendamento em 12/11/2024
@{especialidades_ids}
...    96    # Cardiologia
...    89    # Clínica_Geral
...    98    # Dermatologia
...    247   # Ecografista_Ultrassom
...    104   # Endocrinologia
...    102   # Gastroenterologia
...    128   # Ginecologia
...    101   # Medicina_do_Trabalho
...    121   # Neurologia
...    129   # Ortopedia
...    188   # Psicologia
...    141   # Psiquiatria
...    109   # Reumatologia
...    148   # Urologia

*** Keywords ***
ID De Especialidade Aleatorio
    [Documentation]        Usa a lista de possiveis tipos de consulta para selecionar um ID aleatorio
    ${id_aleatorio}        Evaluate    random.choice(${especialidades_ids})    modules=random
    Return From Keyword    ${id_aleatorio}

Valor Aleatorio De Lista
    [Documentation]    Recebe o caminho de um xPath que exibe uma lista de elementos e seleciona um deles de maneira aleatoria de acordo com o ${parametro_de_retorno}
    [Arguments]      ${xPath_da_lista}    ${parametro_de_retorno}
    ${lista}=        Get WebElements      ${xPath_da_lista}
    ${nomes}=        Create List
    FOR    ${unidade}    IN    @{lista}
        ${nome}=    SeleniumLibrary.Get Element Attribute    ${unidade}    ${parametro_de_retorno}
        Append To List    ${nomes}    ${nome}
    END
    ${unidade_aleatoria}=    Evaluate    random.choice(${nomes})    modules=random
    Return From Keyword    ${unidade_aleatoria}

Escolhe Um Horario Disponivel
    [Documentation]    Usa a API de consulta para escolher uma data disponivel de maneira aleatoria para o ${id_da_especialidade}. Se nenhum ID for informado
    ...    o 96 sera usado como padrao
    [Arguments]        ${id_da_especialidade}=96
    # Faz um get com o ID para ver se e retornado algum horario
    ${response} =                            GET    ${horarios_disponiveis}${id_da_especialidade}
    # Converte a resposta em um json tratavel
    ${json_data} =                           Convert To Dictionary    ${response.json()}
    ${agendamentos_disponiveis} =            Get From Dictionary    ${json_data}    avaiableSchedule
    #${medicos_disponiveis} =                 Get From Dictionary    ${json_data}    professionals
    Log    ${agendamentos_disponiveis}

    # Remove do retorno datas, clinicas e medicos com listas vazias
    # Limpa os itens vazios no primeiro nivel
    ${agendamentos_filtrados}=  Evaluate  {k: v for k, v in ${json_data['avaiableSchedule']}.items() if v != {} and all(val != [] for val in v.values())}  # This removes empty lists
    # Limpa os itens vazios no segundo nivel
    ${agendamentos_filtrados}=  Evaluate  {k: {sk: sv for sk, sv in v.items() if sv} for k, v in ${agendamentos_filtrados}.items() if v}
    # Limpa os itens vazios no terceiro nivel
    ${agendamentos_filtrados}=  Evaluate  {k: {sk: {date: times for date, times in sv.items() if times} for sk, sv in v.items() if sv} for k, v in ${json_data['avaiableSchedule']}.items() if v}
    # Remove os itens vazios no final
    ${agendamentos_filtrados}=  Evaluate  {k: v for k, v in ${agendamentos_filtrados}.items() if v != {}}

    # Retorna falso se nao houver agendamentos para a especialidade
    IF     len(${agendamentos_filtrados}) == 0
        Return From Keyword    "false"
    END

    Log    ${agendamentos_filtrados}

    # Escolhe aleatoriamente uma clinica
    ${clinica_escolhida}=   Evaluate    random.choice(list(${agendamentos_filtrados}.keys()))
    Log    ${clinica_escolhida}
    # Escolhe aleatoriamente um medico
    ${medico_escolhido}=   Evaluate    random.choice(list(${agendamentos_filtrados}[${clinica_escolhida}].keys()))
    Log    ${medico_escolhido}
    # Escolhe aleatoriamente uma data
    ${data_escolhida}=     Evaluate     random.choice(list(${agendamentos_filtrados}[${clinica_escolhida}][${medico_escolhido}].keys()))
    Log    ${data_escolhida}

    # A data pode ser retornada como json ou lista e precisa ser tratada adequadamente
    ${tipo}=               Evaluate    type(${agendamentos_filtrados}[${clinica_escolhida}][${medico_escolhido}][${data_escolhida}])
    ${is_json}=            Run Keyword And Return Status    Should Be Equal As Strings    ${tipo}    <class 'dict'>

    # Escolhe aleatoriamente um horario
    IF    ${is_json}
        ${horario_escolhido}=    Evaluate     random.choice(list(${agendamentos_filtrados}[${clinica_escolhida}][${medico_escolhido}][${data_escolhida}].values()))
    ELSE
        ${horario_escolhido}=    Evaluate     random.choice(list(${agendamentos_filtrados}[${clinica_escolhida}][${medico_escolhido}][${data_escolhida}]))
    END

    # Cria um json com os dados escolhidos
    ${result}=                Create Dictionary    clinica_escolhida=${clinica_escolhida}    medico_escolhido=${medico_escolhido}    data_escolhida=${data_escolhida}    horario_escolhido=${horario_escolhido}
    Return From Keyword       ${result}    ${json_data}

Recupera Nome Da Unidade 
    [Documentation]    Usa as informacoes do agendamento e o json do request inicial para recuperar o nome da clinica
    [Arguments]                              ${json_data}    ${agendamento}
    ${clinicas_disponiveis} =                Get From Dictionary    ${json_data}    units

    #Encontra a clinica escolhida entres as disponiveis
    ${clinica_value}=    Get From Dictionary    ${agendamento}    clinica_escolhida

    # Itera sobre as clinicas do json inicial procurando pela que contenha o ID escolhido e retorna o nome da mesma
    FOR    ${clinica}    IN    @{clinicas_disponiveis}
        ${locais}=            Get From Dictionary    ${clinica}    locais
        ${locais_lista}=      Split String    ${locais}    ,
        ${resultados}=        Get Match Count    ${locais_lista}    ${clinica_value}
        IF    ${resultados} > 0
            Return From Keyword    ${clinica['nome']}
        END
    END

Valida Se Um Horario Esta Disponivel
    [Documentation]
    [Arguments]        ${id_da_especialidade}    ${agendamento}
    # Recupera os horarios disponiveis para agendamento
    ${response} =                            GET    ${horarios_disponiveis}${id_da_especialidade}
    # Converte a resposta em um json tratavel
    ${json_data} =                           Convert To Dictionary    ${response.json()}
    ${agendamentos_disponiveis} =            Get From Dictionary    ${json_data}    avaiableSchedule
    Log    ${agendamento}
    Log    ${agendamentos_disponiveis}

    # Recupera os dados para montar o json no padrao da API para realizar a busca
    ${clinica}=                        Get From Dictionary    ${agendamento}    clinica_escolhida
    ${medico}=                         Get From Dictionary    ${agendamento}    medico_escolhido
    ${dia_escolhido}=                  Get From Dictionary    ${agendamento}    data_escolhida
    ${horario_escolhido}=              Get From Dictionary    ${agendamento}    horario_escolhido

    # Tenta encontrar o caminho na API, se encontrar e porque o horario esta disponivel
    TRY
        ${response_clinica}=    Get From Dictionary    ${agendamentos_disponiveis}            ${clinica}
        ${response_medico}=     Get From Dictionary    ${response_clinica}                    ${medico}
        ${response_data}=       Get From Dictionary    ${response_medico}                     ${dia_escolhido}
    EXCEPT
        # Retorna false em caso de erro porque o horario nao foi encontrado na API, ou seja, esta disponivel
        Return From Keyword     false
    END

    # A data pode ser retornada como json ou lista e precisa ser tratada adequadamente
    ${tipo}=               Evaluate    type(${response_data})
    ${is_json}=            Run Keyword And Return Status    Should Be Equal As Strings    ${tipo}    <class 'dict'>

    IF    ${is_json}
        ${bool}=              Run Keyword And Return Status    Dictionary Should Contain Value    ${response_data}    ${horario_escolhido}
        Return From Keyword    ${bool}
    ELSE
        ${bool}=              Run Keyword And Return Status    List Should Contain Value          ${response_data}    ${horario_escolhido}
        Return From Keyword    ${bool}
    END

Realiza Login
    [Documentation]          Usa os dados do cliente para realizar login
    [Arguments]              ${cpf}    ${senha}

    # Clica na pagina do cliente se ela estiver sendo exibida
    Click Element            xpath=//li[@id='menu-item-2671']
    Sleep                    2

    # Obtem os identificadores das janelas abertas e garante que o robo esta na janela correta
    ${windows}=    Get Window Handles
    Switch Window            ${windows[1]}
    ${title}=                Get Title
    Log                      ${title}

    # Preenche os dados de login
    Sleep                    2
    Input Text               xpath=//input[@id='cpf']         ${cpf}
    Input Text               xpath=//input[@id='password']    ${senha}

    Sleep                    2
    Click Element            xpath=//span[@class='state' and text()='Entrar']    