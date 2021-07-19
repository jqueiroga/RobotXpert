*** Settings ***
Documentation           Suite de testes do Login do Administrador

Resource        ${EXECDIR}/resources/base.robot

Suite Setup     Start Browser Session

Test Teardown   Take Screenshot

*** Test Cases ***
Cenário: Login do Administrador
    Go To Login Page
    Login With                   admin@bodytest.com        pwd123        
    User Should Be Logged In     Administrador

    [Teardown]      Clear LocalStorage and Take Screenshot
 

Cenário: Senha Incorreta
    [Tags]      wip
    Go To Login Page
    Login With          admin@bodytest.com                abc123                                      
    Toast Should Be     Usuário e/ou senha inválidos.

    [Teardown]          Thinking And Take Screenshot  2

Cenário: Email Incorreto
    Go To Login Page
    Login With              admin$bodytest.com            pwd123 
    Alert Text Should Be    Informe um e-mail válido


Cenário: Senha Não Informada
    Go To Login Page
    Login With               admin2bodytest.com           ${EMPTY}
    Alert Text Should Be     A senha é obrigatória


Cenário: Email Não Informada
    Go To Login Page
    Login With               ${EMPTY}                    pwd123 
    Alert Text Should Be     O e-mail é obrigatório

Cenário: Email e Senha Não Informados
    Go To Login Page
    Login With                ${EMPTY}                 ${EMPTY}  

    Alert Text Should Be      O e-mail é obrigatório
    Alert Text Should Be      A senha é obrigatória

