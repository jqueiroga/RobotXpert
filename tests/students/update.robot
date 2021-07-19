*** Settings ***
Documentation                       Suite de Atualização de Alunos

Resource         ${EXECDIR}/resources/base.robot

Suite Setup     Start Admin Session
Test Teardown   Take Screenshot

*** Test Cases ***
Cenário: Atualizar um aluno já cadastrado

    ${updateJson}       Get JSON            students-update.json

    ${kamalakhan}       Set Variable        ${updateJson['before']}
    ${msmarvel}         Set Variable        ${updateJson['after']}

    Remove Student By Name      ${kamalakhan['name']}
    Remove Student By Name      ${msmarvel['name']}

    Insert Student              ${kamalakhan}

    Go To Students
    Search Stundent By Name     ${kamalakhan['name']}
    Go To Update Form           ${kamalakhan['email']}      Edição de aluno
    Update A Student            ${msmarvel} 

    Toast Should Be             Aluno atualizado com sucesso.   

    [Teardown]      Thinking And Take Screenshot        2     