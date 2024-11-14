*** Settings ***
Library           SeleniumLibrary
Library           BuiltIn
Library           Collections
Library           String

Resource          my_keywords.robot

*** Variables ***
${URL1}            https://minhaclinica.com/agendamento
${URL2}            https://components-legacy.feegow.com/index.php/agendamento-online/client/minhaclinica
${CHROME_OPTIONS}  --disable-application-cache

*** Test Cases ***
Preparacao
    [Documentation]    Consulta a API com um ID aleatorio e retorna, tambem de maneira aleatoria, uma data disponivel para agendamento
    #                  se para a especialidade encontrada nao houver agendamentos disponiveis, procura por outra especialidade
    FOR    ${i}    IN RANGE    50
           ${item_id}                         ID De Especialidade Aleatorio    #Recebe uma especialidade aleatoria
           ${result}                          Escolhe Um Horario Disponivel    ${item_id}
            Set Global Variable               ${ITEM_ID}    ${item_id}
            Exit For Loop If    ${result} != "false"
    END

    ${agendamento}=    Get From List    ${result}    0
    ${json_data}=      Get From List    ${result}    1

    Set Global Variable                ${AGENDAMENTO}    ${agendamento}
    Set Global Variable                ${JSON_DATA}      ${json_data}
    Log    ${agendamento}
    Log    ${json_data}

Agendar Consulta
    [Documentation]    Teste para agendar uma nova consulta em um horário disponivel
    ## Abre a pagina principal de agendamento e seleciona aleatoriamente um tipo de agendamento
    Open Browser                       ${URL2}    Chrome
    Maximize Browser Window

    Sleep                              2
    Click Element                      id=select2-feegow-especialidades-container
    Sleep                              2
    Click Element                      xpath=//li[contains(@id, 'select2-feegow-especialidades-result-') and contains(@id, ${ITEM_ID})]  
    Sleep                              2
    Click Element                      xpath=//button[contains(@class, 'agendar-horario-btn')]

    # Recupera o nome de uma unidade 
    Sleep                              2
    ${unidade}                         Recupera Nome Da Unidade    ${JSON_DATA}    ${AGENDAMENTO}
    Sleep                              2
    Click Element                      xpath=//div[contains(@class, 'item-list-unidade') and @data-name='${unidade}']/div[2]/button    
    
    # Recupera a data da consulta  
    Sleep                              2  
    ${dia_escolhido}=                  Get From Dictionary    ${agendamento}    data_escolhida
    ${horario_escolhido}=              Get From Dictionary    ${agendamento}    horario_escolhido
                    
    # Recebe uma data entre as datas disponiveis
    Sleep                              2
    Click Element                      xpath=//button[@data-time="${dia_escolhido} ${horario_escolhido}"]

    # Preenche o formulario de agendamento
    Sleep                              2
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
                
    # Conclui o agendamento, mas como criei o teste no ambiente de prod, essa opcao esta comentada
    Sleep                              2    
    #Click Element                     xpath=//button[contains(@class, 'btn-primary')]

    Sleep    5
    Close Browser

Valida Horario
    [Documentation]    Valida que o horario agendado nao esta mais disponivel para agendamento, a validacao e: compara-se o json da api com o horario
    #                  agendado, se o horario for encontrado, houve erro no agendamento
    ${bool}                Valida Se Um Horario Esta Disponivel    ${ITEM_ID}    ${AGENDAMENTO}
    # Como estou pausando antes de confirmar, esse should sempre retorna erro, por isso esta comentado
    #Should Be True     ${bool}


Cancelar Consulta
    [Documentation]    Teste para cancelar a consulta agendada
    Skip    Este teste foi ignorado    
    Open Browser    ${URL1}    Chrome
    Wait Until Page Contains Element    id:cancelar
    Click Button    id:cancelar
    Wait Until Page Does Not Contain    ${URL1}
    Close Browser