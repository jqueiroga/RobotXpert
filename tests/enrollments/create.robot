*** Settings ***
Documentation                       Suite de Cadastro de Matrículas.

Resource         ${EXECDIR}/resources/base.robot

Suite Setup     Start Admin Session
Test Teardown   Take Screenshot

*** Test Cases ***
Cenário: Deve exibir data inicial e final conforme o plano escolhido
    [Tags]      wip
    ${fixture}      Get JSON           enrolls-dates.json
    ${student}      Set Variable       ${fixture['student']}
    ${plan}        Set Variable        ${fixture['plan']}

    Insert Student      ${student}
    Insert Plan         ${plan}

    Go To Enrolls
    Go To Form Enrolls

    Select Student      ${student['name']}
    Select Plan         ${plan['title']}

    Start Date Should Today
    End Date Should Be          ${fixture['days']}

Cenário: Deve matricular um aluno em um plano

    ${fixture}      Get JSON           enrolls-create.json
    ${student}      Set Variable       ${fixture['student']}
    ${plan}        Set Variable        ${fixture['plan']}

    Insert Student      ${student}
    Insert Plan         ${plan}

    Go To Enrolls
    Go To Form Enrolls

    Select Student      ${student['name']}
    Select Plan         ${plan['title']}
    
    Submit Enrolls Form 

    Toast Should Be     Matrícula cadastrada com sucesso

    [Teardown]          Thinking And Take Screenshot        5