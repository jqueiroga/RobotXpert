*** Settings ***
Documentation               Arquivo base do Projeto de Automação

Library         Browser
Library         Collections
Library         OperatingSystem

Library         libs/DeloreanLibrary.py

Resource        actions/auth.robot
Resource        actions/components.robot
Resource        actions/navigation.robot
Resource        actions/students.robot
Resource        actions/plans.robot

*** Keywords ***
Start Browser Session
    New Browser     chromium    False
    New Page        about:blank

Start Admin Session
    Start Browser Session
    Go To Login Page
    Login With                   admin@bodytest.com        pwd123        
    User Should Be Logged In     Administrador

Clear LocalStorage and Take Screenshot
    LocalStorage Clear
    Take Screenshot

Thinking And Take Screenshot
    [Arguments]     ${timeout}

    Sleep           ${timeout}
    Take Screenshot

######## HELPERS ###########
Get JSON
    [Arguments]     ${filen_name}

    ${file}=          Get File      ${EXECDIR}/resources/fixture/${filen_name}
    ${jsonObject}     Evaluate      json.loads($file)         json

    [return]          ${jsonObject}