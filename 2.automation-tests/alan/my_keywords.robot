*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    RequestsLibrary

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

Verifica Horario Disponivel
    [Documentation]    
    [Arguments]        ${id_da_especialidade}=96
    # Faz um get com o ID (padrao 96) para ver se e retornado algum horario
    ${response} =    GET    ${horarios_disponiveis}${id_da_especialidade}
    # Converte a resposta em um json tratavel
    ${json_data} =    Convert To Dictionary    ${response.json()}
    ${agendamentos_disponiveis} =    Get From Dictionary    ${json_data}    avaiableSchedule
    ${medicos_disponiveis} =    Get From Dictionary    ${json_data}    avaiableSchedule
    ${clinicas_disponiveis} =    Get From Dictionary    ${json_data}    avaiableSchedule
    Log    ${agendamentos_disponiveis}

    # Remove do retorno datar, clinicas e medicos com listas vazias
    # Limpa os itens vazios no primeiro nivel
    ${agendamentos_filtrados}=  Evaluate  {k: v for k, v in ${json_data['agendamentos_disponiveis']}.items() if v != {} and all(val != [] for val in v.values())}  # This removes empty lists
    # Limpa os itens vazios no segundo nivel
    ${agendamentos_filtrados}=  Evaluate  {k: {sk: sv for sk, sv in v.items() if sv} for k, v in ${agendamentos_filtrados}.items() if v}
    # Limpa os itens vazios no terceiro nivel
    ${agendamentos_filtrados}=  Evaluate  {k: {sk: {date: times for date, times in sv.items() if times} for sk, sv in v.items() if sv} for k, v in ${json_data['agendamentos_disponiveis']}.items() if v}
    # Remove os itens vazios no final
    ${agendamentos_filtrados}=  Evaluate  {k: v for k, v in ${agendamentos_filtrados}.items() if v != {}}
    Log    ${agendamentos_filtrados}