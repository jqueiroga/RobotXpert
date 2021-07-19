*** Settings ***
Documentation               Ações de Autorização


*** Keywords ***
Go To Login Page
    Go To           https://bodytest-web-homolog.herokuapp.com/ 


Login With
    [Arguments]     ${email}        ${password}

    Fill Text       css=input[name=email]           ${email}              
    Fill Text       css=input[name=password]        ${password}  
    Click           text=Entrar        

