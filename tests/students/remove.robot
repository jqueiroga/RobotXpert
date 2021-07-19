*** Settings ***
Documentation                       Suite de Remoção de Alunos

Resource         ${EXECDIR}/resources/base.robot

Test Setup     Start Admin Session
Test Teardown   Take Screenshot

*** Test Cases ***
Cenário: Remover aluno cadastrado

    &{student}       Create Dictionary      name=Maria Heloisa Costa    email=heloicacosta@isa.com     age=38      weight=70   feet_tall=1.62  

    Insert Student                   ${student}  
    Go To Students
    Search Stundent By name          ${student.name}
    Request Removal By Reference     ${student.email}
    Confirm Removal Register
    Toast Should Be                  Aluno removido com sucesso.
    Element Should Not Visible       ${student.email}


      [Teardown]      Thinking And Take Screenshot        2   
    
Cenário: Desistir da Exclusão
    &{student}       Create Dictionary      name=Sr. João Batista    email=batjoao@vovo.com     age=68      weight=70   feet_tall=1.62  

    Insert Student                  ${student}  
    Go To Students   
    Search Stundent By name         ${student.name}
    Request Removal By Reference    ${student.email}
    Cancel Removel
    Element Should Be Visible       ${student.email}

