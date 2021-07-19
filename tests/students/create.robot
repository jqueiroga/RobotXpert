*** Settings ***
Documentation                       Suite de Cadastro de Alunos

Resource         ${EXECDIR}/resources/base.robot

Suite Setup     Start Admin Session
Test Teardown   Take Screenshot

*** Test Cases ***
Cenário: Novo Aluno
    [Tags]      newStudent
    &{student}       Create Dictionary      name=Jeremias Araújo    email=jqcaraujo@hotmail.com     age=39      weight=83   feet_tall=1.77   

    Remove Student            ${student.email}
    Go To Students
    Go To Form Student
    New Student               ${student}
    Toast Should Be           Aluno cadastrado com sucesso.

    [Teardown]      Thinking And Take Screenshot        2                                                                                                                                         

Cenário: Não deve permitir email duplicado
    [Tags]      duplicated

    &{student}       Create Dictionary      name=João Henrique    email=jh2@galego.com     age=15      weight=20   feet_tall=0.90  

    #Inserindo usuário para testes
    Insert Student            ${student}  
    Go To Students
    Go To Form Student
    New Student               ${student}
    Toast Should Be           Email já existe no sistema.

    [Teardown]      Thinking And Take Screenshot        2                                                                                                                                         


Cenário: Todos os campos obrigatórios
    [Tags]      required

    @{expect_alerts}    Set Variable    Nome é obrigatório      O e-mail é obrigatório      idade é obrigatória     o peso é obrigatório        a Altura é obrigatória
    @{got_alerts}       Create List

    Go To Students
    Go To Form Student
    Submit Student Form

    FOR     ${index}    IN RANGE      1     6
        ${span}             Get Required Alerts     ${index}
        Append To List      ${got_alerts}           ${span}
    END

    Lists Should Be Equal       ${expect_alerts}         ${got_alerts} 


#Caso de Teste que é implementado pelo comportamento da Keywork de Check Numeric 
#Conjunto de passos de testes compartilhados
Cenário: Validação dos campos numericos
    [Tags]      validateField    
    [Template]  Check Type Field On Student Form   
    ${AGE_FIELD}             number  
    ${WEIGHT_FIELD}          number
    ${FEET_TALL_FIELD}       number

Cenário: Validar campo do tipo email
    [Tags]      validateField    
    [Template]  Check Type Field On Student Form   
    ${EMAIL_FIELD}           email  

Cenário: Menor de 14 anos não pode fazer Cadastro
    [Tags]      wip

    &{student}       Create Dictionary      name=João Helio    email=jh@galego.com     age=6      weight=30   feet_tall=1.10  

    Go To Students
    Go To Form Student
    New Student     ${student}
    Alert Text Should Be            A idade deve ser maior ou igual 14 anos


*** Keywords ***
Check Type Field On Student Form
    [Arguments]     ${fieldElement}     ${fieldType}

    Go To Students
    Go To Form Student
    Field Should Be Type       ${fieldElement}        ${fieldType}    
