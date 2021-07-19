*** Settings ***
Documentation                       Suite de Busca de Alunos

Resource         ${EXECDIR}/resources/base.robot

Test Setup     Start Admin Session
Test Teardown   Take Screenshot

*** Test Cases ***
Cenário: Busca Exata
    &{student}       Create Dictionary      name=Steve Jobs    email=jobs@ape.com     age=48      weight=79   feet_tall=1.82  

    Remove Student By Name             ${student.name} 
    Insert Student                     ${student}  
    Go To Students   
    Search Stundent By name            ${student.name}
    Student Name Should Be visible     ${student.name}
    Total Itens Should Be              1

Cenário: Registro Não encontrado
    &{student}       Create Dictionary      name=Barão da Pisadinha    email=barao@pisadinha.com     age=48      weight=79   feet_tall=1.82  

    Remove Student By Name             ${student.name} 

    Go To Students   
    Search Stundent By Name            ${student.name}
    Register Should Not Be Found

Cenário: Busca alunos por um único termo
    [Tags]  wip
    
    ${fixture}          Get JSON        students-search.json  
    ${nameSearch}       Set Variable    ${fixture['word']}
    ${totalItens}       Set Variable    ${fixture['total']} 
    ${students}         Set Variable    ${fixture['students']}
   
    Remove Student By Name              ${nameSearch} 

    FOR   ${item}   IN   @{students}
       Insert Student    ${item}
    END

    Go To Students
    Search Stundent By Name         ${nameSearch} 

    FOR   ${item}   IN   @{students}
       Student Name Should Be Visible       ${item['name']}
    END

    Total Itens Should Be              ${totalItens}
