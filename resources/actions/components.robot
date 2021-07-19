*** Settings ***
Documentation           Ações de Componentes Genéricos


*** Keywords ***
### VALIDATIONS ###
Toast Should Be
    [Arguments]     ${expect_text}
    
    Wait For Elements State         css=.Toastify__toast-body >> text=${expect_text}     Visible        5

Alert Text Should Be
    [Arguments]     ${expect_msg}

    Wait For Elements State         css=form span >> text=${expect_msg}     Visible        5

Field Should Be Type
    [Arguments]     ${field}        ${type}

    ${attr}     Get Attribute       ${field}     type
    Should Be Equal     ${attr}     ${type}

Register Should Not Be Found
    Wait For Elements State            css=div >> text=Nenhum registro encontrado.      visible       5
    Wait For Elements State            css=table                                        detached      5

Total Itens Should Be
    [Arguments]  ${numbers}

    ${element}    Set Variable   css=#pagination .total

    Wait For Elements State       ${element}        visible         5
    Get Text                      ${element}        ==              Total: ${numbers} 

Request Removal By Reference
    [Arguments]     ${reference}

    Click       xpath=//td[contains(text(),"${reference}")]/../td//button[@id="trash"]

Confirm Removal Register
    Click       text=SIM, pode apagar!

Cancel Removel
    Click       text=NÃO

### RETURN ELEMENTS OR TEXT ###
Get Required Alerts
    [Arguments]     ${index}
    
    ${span}     Get Text    xpath=(//form//span)[${index}]

    [return]      ${span}


### VALIDATIONS ###
Element Should Not Visible 
    [Arguments]         ${reference}

    Wait For Elements State          xpath=//td[contains(text(),"${reference}")]        detached        5

Element Should Be Visible 
    [Arguments]         ${reference}

    Wait For Elements State          xpath=//td[contains(text(),"${reference}")]        visible        5

### LINKS AND BUTTONS ###
Go To Update Form
    [Arguments]     ${reference}        ${text}

    Click                           xpath=//td[contains(text(), "${reference}")]/..//a[@class="edit"]
    Wait For Elements State         css=h1 >> text=${text}     Visible         5