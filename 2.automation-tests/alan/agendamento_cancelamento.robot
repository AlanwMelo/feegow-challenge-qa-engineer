*** Settings ***
Library           SeleniumLibrary
Library           BuiltIn
Library           Collections
Library           String

Resource          my_keywords.robot

*** Variables ***
${URL1}            https://minhaclinica.com/agendamento
${URL2}            https://components-legacy.feegow.com/index.php/agendamento-online/client/minhaclinica

*** Test Cases ***
Preparacao
    # O mais perto que encontrei de um while
    FOR    ${i}    IN RANGE    50
           Log    ${i}
           ${item_id}                         IDs De Especialidades Aleatorio    #Recebe uma especialidade aleatoria
           ${result}                          Escolhe Um Horario Disponivel    ${item_id}
            Set Global Variable                ${ITEM_ID}    ${item_id}
            Exit For Loop If    ${result} != "false"
    END

    ${agendamento}=    Get From List    ${result}    0
    ${json_data}=      Get From List    ${result}    1

    Set Global Variable                ${AGENDAMENTO}    ${agendamento}
    Set Global Variable                ${JSON_DATA}    ${json_data}
    Log    ${agendamento}
    Log    ${json_data}

Agendar Consulta
    [Documentation]    Teste para agendar uma nova consulta em um horário disponível
    ## Abre a pagina principal de agendamento e seleciona aleatoriamente um tipo de agendamento
    Open Browser                       ${URL2}    Chrome
    Maximize Browser Window

    Sleep                              3
    Click Element                      id=select2-feegow-especialidades-container
    Sleep                              1
    Click Element                      xpath=//li[contains(@id, 'select2-feegow-especialidades-result-') and contains(@id, ${ITEM_ID})]  
    Sleep                              1
    Click Element                      xpath=//button[contains(@class, 'agendar-horario-btn')]
    
    Sleep                              3
    # Recupera o nome de uma unidade
    ${unidade}                         Recupera Nome Da Unidade    ${JSON_DATA}    ${AGENDAMENTO}
    Sleep                              2
    Click Element                      xpath=//div[contains(@class, 'item-list-unidade') and @data-name='${unidade}']/div[2]/button    
    
    Sleep      3
    # Recupera a data da consulta    
    ${dia_escolhido}=                  Get From Dictionary    ${agendamento}    data_escolhida
    ${horario_escolhido}=              Get From Dictionary    ${agendamento}    horario_escolhido
                    
    # Recebe uma data entre as datas disponiveis
    Sleep                              2
    Click Element                      xpath=//button[@data-time="${dia_escolhido} ${horario_escolhido}"]

    # Preenche o formulario de agendamento
    Sleep                              3
    Input Text                         xpath=//input[@name='nome']                     Fabricio Ficticio
    Input Text                         xpath=//input[@name='nascimento']               14/09/1974
    Click Element                      xpath=//input[@id='sexo-masculino' and @type='radio']
    Input Text                         xpath=//input[@name='cpf']                      67558243050
    Input Text                         xpath=//input[@name='celular']                  119968246982
    Input Text                         xpath=//input[@name='email']                    fabricio@ficticio.com
    Input Text                         xpath=//textarea[@id='obs']                     Minhas Observacoes
    Click Element                      xpath=//span[@id='select2-origem-container']
    ${como_conheceu}                   Valor Aleatorio De Lista    xpath=//li[@class='select2-results__option']    id
    Click Element                      xpath=//li[@id='${como_conheceu}']
    
    Sleep                              2                
    # Conclui o agendamento, como criei o teste no ambiente de prod, essa opcao esta comentada
    #Click Element                     xpath=//button[contains(@class, 'btn-primary')]
    Set Global Variable                ${UNIDADE}        ${unidade}
    Set Global Variable                ${AGENDAMENTO}    ${agendamento}

    Sleep    10
    Close Browser

Valida Horario
    [Documentation]    Valida que o horario agendado nao esta mais disponivel para agendamento
    Skip
    Verifica Horarios Disponiveis


Cancelar Consulta
    [Documentation]    Teste para cancelar a consulta agendada
    Skip    Este teste foi ignorado    
    Open Browser    ${URL1}    Chrome
    Wait Until Page Contains Element    id:cancelar
    Click Button    id:cancelar
    Wait Until Page Does Not Contain    ${URL1}
    Close Browser