*** Settings ***
Documentation                       Suite de Cadastro de Planos

Resource         ${EXECDIR}/resources/base.robot

Suite Setup     Start Admin Session
Test Teardown   Take Screenshot

*** Test Cases ***
Cenário: Calcular preço total do plano

    &{plan}          Create Dictionary       title=Papito Teste      duration=12     price=19,99     total=R$ 239,88

    Remove Plan            ${plan.title}
    Go To Plans
    Go To Form Plan
    Fill Plan Form          ${plan}   
    Total Plan Should Be    ${plan.total}

Cenário: Validar todos os campos obrigatórios

    @{expect_alerts}    Set Variable    Informe o título do plano      Informe a duração do plano em meses
    @{got_alerts}       Create List

    Go To Plans
    Go To Form Plan
    Submit Plan Form

    FOR     ${index}    IN RANGE      1     3
        ${span}             Get Required Alerts     ${index}
        Append To List      ${got_alerts}           ${span}
    END

    Lists Should Be Equal       ${expect_alerts}         ${got_alerts} 

Cenário: Validar que o plano deve ter no mínimo 1 mês

   &{plan}          Create Dictionary       title=Papito Teste      duration=0     price=19,99     total=R$ 239,88

    Remove Plan            ${plan.title}
    Go To Plans
    Go To Form Plan
    New Plan               ${plan}   

    ${msgMinimumDuration}    Set Variable   xpath=(//form//span) >> text=A duração dever ser no mínimo 1 mês

    Wait For Elements State       ${msgMinimumDuration}        visible         5

Cenário: Validar que o plano deve ter no máximo 60 meses

   &{plan}          Create Dictionary       title=Papito Teste      duration=70     price=19,99     total=R$ 239,88

    Remove Plan            ${plan.title}
    Go To Plans
    Go To Form Plan
    New Plan               ${plan}   

    ${msgMinimumDuration}    Set Variable   xpath=(//form//span) >> text=A duração dever ser no máximo 60 meses

    Wait For Elements State       ${msgMinimumDuration}        visible         5


Cenário: Validar mensagem de erro ao criar plano sem preço
   [Tags]           wip
   &{plan}          Create Dictionary       title=Plano Zero      duration=7     price=     total=R$ 239,88

    Remove Plan            ${plan.title}
    Go To Plans
    Go To Form Plan
    Fill Text   ${TITLE_FIELD}             ${plan.title}
    Fill Text   ${DURATION_FIELD}          ${plan.duration} 
    Submit Plan Form
    
    Toast Should Be        O valor do plano deve ser maior que zero!





