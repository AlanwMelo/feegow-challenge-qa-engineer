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
IDs De Especialidades Aleatorio
    [Documentation]        Usa a lista de possiveis tipos de consulta para selecionar um ID aleatoria
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
    [Documentation]    
    [Arguments]        ${id_da_especialidade}=96
    # Faz um get com o ID (padrao 96) para ver se e retornado algum horario
    ${response} =                            GET    ${horarios_disponiveis}${id_da_especialidade}
    # Converte a resposta em um json tratavel
    ${json_data} =                           Convert To Dictionary    ${response.json()}
    ${agendamentos_disponiveis} =            Get From Dictionary    ${json_data}    avaiableSchedule
    ${medicos_disponiveis} =                 Get From Dictionary    ${json_data}    professionals
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
    ${clinina_escolhida}=   Evaluate    random.choice(list(${agendamentos_filtrados}.keys()))
    Log    ${clinina_escolhida}
    # Escolhe aleatoriamente um medico
    ${medico_escolhido}=   Evaluate    random.choice(list(${agendamentos_filtrados}[${clinina_escolhida}].keys()))
    Log    ${medico_escolhido}
    # Escolhe aleatoriamente uma data
    ${data_escolhida}=     Evaluate     random.choice(list(${agendamentos_filtrados}[${clinina_escolhida}][${medico_escolhido}].keys()))
    Log    ${data_escolhida}

    # A data pode ser retornada como json ou lista e precisa ser tratada adequadamente
    ${tipo}=               Evaluate    type(${agendamentos_filtrados}[${clinina_escolhida}][${medico_escolhido}][${data_escolhida}])
    ${is_json}=            Run Keyword And Return Status    Should Be Equal As Strings    ${tipo}    <class 'dict'>

    # Escolhe aleatoriamente um horario
    IF    ${is_json}
        ${horario_escolhido}=    Evaluate     random.choice(list(${agendamentos_filtrados}[${clinina_escolhida}][${medico_escolhido}][${data_escolhida}].keys()))
    ELSE
        ${horario_escolhido}=    Evaluate     random.choice(list(${agendamentos_filtrados}[${clinina_escolhida}][${medico_escolhido}][${data_escolhida}]))
    END

    # Cria um json com os dados escolhidos
    ${result}=                Create Dictionary    clinina_escolhida=${clinina_escolhida}    medico_escolhido=${medico_escolhido}    data_escolhida=${data_escolhida}    horario_escolhido=${horario_escolhido}
    Return From Keyword       ${result}    ${json_data}

Recupera Nome Da Unidade 
    [Documentation]
    [Arguments]                              ${json_data}    ${agendamento}
    ${clinicas_disponiveis} =                Get From Dictionary    ${json_data}    units
    Log    ${json_data}
    Log    ${clinicas_disponiveis}
    Log    ${agendamento}
    ${clinica_value}=    Get From Dictionary    ${agendamento}    clinina_escolhida
    Log    O valor de clinica é ${clinica_value}

    FOR    ${clinica}    IN    @{clinicas_disponiveis}
        ${locais}=            Get From Dictionary    ${clinica}    locais
        ${locais_lista}=      Split String    ${locais}    ,
        ${bool}=              Run Keyword And Return Status    List Should Contain Value    ${locais_lista}    ${clinica_value}
        IF    ${bool}
            Return From Keyword    ${clinica['nome']}
        END
    END