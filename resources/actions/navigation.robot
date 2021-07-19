*** Settings ***
Documentation               Ações do Menu Superior de Navegação


*** Keywords ***
User Should Be Logged In
    [Arguments]     ${user_name}

    Get Text        aside strong       Should Be     ${user_name}

Go To Students
    Click       css=a[href$=alunos]
    Wait For Elements State         css=h1 >> text=Gestão de Alunos     Visible         5

Go To Plans
    Click       css=a[href$=planos]
    Wait For Elements State         css=h1 >> text=Gestão de Planos     Visible         5

Do Logout
    Click       css=h1 >> text=Sair