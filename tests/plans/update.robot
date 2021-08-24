*** Settings ***
Documentation                       Suite de Atualização de Planos

Resource         ${EXECDIR}/resources/base.robot

Suite Setup     Start Admin Session
Test Teardown   Take Screenshot

*** Test Cases ***
Cenário: Atualizar um Plano já cadastrado

    ${updateJson}       Get JSON            plans-update.json

    ${planBefore}        Set Variable        ${updateJson['before']}
    ${planAfter}         Set Variable        ${updateJson['after']}

    Remove Plan              ${planBefore['title']}
    Remove Plan              ${planAfter['title']}

    Insert Plan              ${planBefore}

    Go To Plans
    Search Plan By Title     ${planBefore['title']}
    Go To Update Form        ${planBefore['title']}       Edição de plano
    Update Plan              ${planAfter} 

    Toast Should Be             Plano Atualizado com sucesso   

    [Teardown]      Thinking And Take Screenshot        2     