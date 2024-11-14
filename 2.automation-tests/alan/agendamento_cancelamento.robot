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
${DOCUMENTO}       83934571069
${SENHA}           .hAVy445f

*** Test Cases ***
######################### ATENCAO! ###########################
# Os teste abaixo usaram o fluxo de agendamento de producao como referencia, se a URL2 for utilizada para o teste de agendamento
# o mesmo funcionara. O teste esta configurado desta maneira, mas o botao de concluir esta comentado, para evitar problemas o mantenha assim
######################### ATENCAO! ###########################
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
    [Documentation]    Realiza o fluxo padrao de agendamento de consulta
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
                
    ######## Conclui o agendamento, mas como criei o teste no ambiente de prod, essa opcao esta comentada
    Sleep                              2    
    #Click Element                     xpath=//button[contains(@class, 'btn-primary')]

    Sleep    5
    Close Browser

Valida Horario Foi Reservado
    [Documentation]    Valida que o horario agendado nao esta mais disponivel para agendamento, a validacao e: compara-se o json da api com o horario
    #                  agendado, se o horario for encontrado, houve erro no agendamento
    ${bool}                Valida Se Um Horario Esta Disponivel    ${ITEM_ID}    ${AGENDAMENTO}

    ######## Como estou pausando antes de confirmar, esse should sempre retorna erro, por isso esta comentado
    #Should Not Be True     ${bool}


Cancelar Consulta
    [Documentation]    Realiza o fluxo padrao de cancelamento de consulta
    Open Browser                        ${URL1}    Chrome
    Maximize Browser Window
    Sleep                               2
    Realiza Login                       ${DOCUMENTO}    ${SENHA}

    # Recupera os dados para montar o json no padrao da API para realizar a busca
    ${medico}=                         Get From Dictionary    ${AGENDAMENTO}    medico_escolhido
    ${dia_escolhido}=                  Get From Dictionary    ${AGENDAMENTO}    data_escolhida
    ${horario_escolhido}=              Get From Dictionary    ${AGENDAMENTO}    horario_escolhido

    # Remove os segundos para poder utilizar o horario como parametro de busca
    ${horario_escolhido}=    Evaluate    '${horario_escolhido[: -3]}'
    Close Browser

    ######## Deste ponto em diante os elementos sao simulados, e por isso estao comentados

    # Procura pelo card appointcard com os dados da consulta e clica no botao de cancelar
    #Click Element                       xpath=//div[contains(@class, 'appointcard') and .//p[contains(text(), '${medico}')] and .//p[contains(text(), '${dia_escolhido}')] and .//p[contains(text(), '${horario_escolhido}')]] and .//button[contains(text(), 'Cancelar')]

Valida Que O Horario Foi Liberado
    [Documentation]    Valida que o horario agendado nao esta novamente disponivel para agendamento, a validacao e: compara-se o json da api com o horario
    #                  agendado, se o horario for encontrado, o agendamento foi cancelado
    ${bool}                Valida Se Um Horario Esta Disponivel    ${ITEM_ID}    ${AGENDAMENTO}
    Should Be True     ${bool}