*** Settings ***
Documentation               Ações de feature de Gestão de Planos

*** Variables ***
${TITLE_FIELD}             id=title
${DURATION_FIELD}          id=duration 
${PRICE_FIELD}             css=input[name=price] 
${TOTAL_FIELD}             css=input[name=total]

*** Keywords ***
Fill Plan Form
    [Arguments]     ${plan}

    Fill Text   ${TITLE_FIELD}             ${plan.title}
    Fill Text   ${DURATION_FIELD}          ${plan.duration} 
    Fill Text   ${PRICE_FIELD}             ${plan.price} 

New Plan
    [Arguments]          ${plan}

    Fill Plan Form       ${plan}
    Submit Plan Form

Update Plan
    [Arguments]     ${plan}

    Fill Text   ${TITLE_FIELD}             ${plan['title']}
    Fill Text   ${DURATION_FIELD}          ${plan['duration']} 
    Fill Text   ${PRICE_FIELD}             ${plan['price']} 

    Submit Plan Form


Submit Plan Form
    Click       css=button[form=formPlan] 

Go To Form Plan
    Click       css=a[href$="planos/new"]
    Wait For Elements State         css=h1 >> text=Novo plano     Visible         5
    

Search Plan By Title 
    [Arguments]   ${title}

    Fill Text     css=input[placeholder="Buscar plano"]         ${title}



### Validations
Total Plan Should Be
    [Arguments]     ${totalExpect}

    Get Attribute       ${TOTAL_FIELD}      value       equal      ${totalExpect}

Plan Name Should Be Visible
    [Arguments]     ${title}

    Wait For Elements State          css=table tbody tr >> text=${title}            visible        5
