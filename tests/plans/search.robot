*** Settings ***
Documentation                       Suite de Busca de Planos Cadastrados

Resource         ${EXECDIR}/resources/base.robot

Test Setup      Start Admin Session
Test Teardown   Take Screenshot

*** Test Cases ***
Cenário: Busca Plano Cadastrado
    &{plan}          Create Dictionary       title=Plano Nacional      duration=12     price=19.99     total=R$ 239,88

    Remove Plan                        ${plan.title}
    Insert Plan                        ${plan}
    Go To Plans
    Search Plan By Title               ${plan.title}
    Element Should Be Visible          ${plan.title}
    Total Itens Should Be              1

Cenário: Registro Não encontrado
     &{plan}          Create Dictionary       title=Plano Nacional      duration=12     price=19.99     total=R$ 239,88

    Remove Plan                        ${plan.title}

    Go To Plans
    Search Plan By Title               ${plan.title}
    Register Should Not Be Found

Cenário: Buscar plano por termo    
    [Tags]      wip
    ${fixture}          Get JSON        plans-search.json  
    ${termSearch}       Set Variable    ${fixture['word']}
    ${totalItens}       Set Variable    ${fixture['total']} 
    ${plans}            Set Variable    ${fixture['plans']}
   
    Remove Plan By Term              ${termSearch} 

    FOR   ${plan}   IN   @{plans}
       Insert Plan    ${plan}
    END

    Go To plans
    Search Plan By Title               ${termSearch} 

    FOR   ${plan}   IN   @{plans}
       Plan Name Should Be Visible       ${plan['title']}
    END

    Total Itens Should Be              ${totalItens}
