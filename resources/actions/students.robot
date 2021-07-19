*** Settings ***
Documentation               Ações de feature de Gestão de Alunos

*** Variables ***
${NAME_FIELD}           css=input[name=name] 
${EMAIL_FIELD}          css=input[name=email] 
${AGE_FIELD}            css=input[name=age] 
${WEIGHT_FIELD}         css=input[name=weight] 
${FEET_TALL_FIELD}      css=input[name=feet_tall] 

*** Keywords ***
### FORMS ###
New Student
    [Arguments]     ${student}

    Fill Text   ${NAME_FIELD}               ${student.name}
    Fill Text   ${EMAIL_FIELD}              ${student.email} 
    Fill Text   ${AGE_FIELD}                ${student.age} 
    Fill Text   ${WEIGHT_FIELD}             ${student.weight}
    Fill Text   ${FEET_TALL_FIELD}          ${student.feet_tall}

    Submit Student Form

Update A Student
    [Arguments]     ${student}

    Fill Text   ${NAME_FIELD}               ${student['name']}
    Fill Text   ${EMAIL_FIELD}              ${student['email']} 
    Fill Text   ${AGE_FIELD}                ${student['age']} 
    Fill Text   ${WEIGHT_FIELD}             ${student['weight']}
    Fill Text   ${FEET_TALL_FIELD}          ${student['feet_tall']}

    Submit Student Form   

Search Stundent By Name 
    [Arguments]   ${name}

    Fill Text     css=input[placeholder="Buscar aluno"]         ${name}


Submit Student Form
    Click       css=button[form=formStudent] 


### LINKS AND BUTTONS ###
Go To Form Student
    Click       css=a[href$="alunos/new"]
    Wait For Elements State         css=h1 >> text=Novo aluno     Visible         5



### VALIDATIONS ###
Student Name Should Be Visible
    [Arguments]     ${name}

    Wait For Elements State          css=table tbody tr >> text=${name}            visible        5

