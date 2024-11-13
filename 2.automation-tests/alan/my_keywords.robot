*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections

*** Variables ***
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
