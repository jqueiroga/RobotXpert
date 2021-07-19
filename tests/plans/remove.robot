*** Settings ***
Documentation                       Suite de Remoção de Planos

Resource         ${EXECDIR}/resources/base.robot

Test Setup      Start Admin Session
Test Teardown   Take Screenshot

*** Test Cases ***
Cenário: Remover plano cadastrado

    &{plan}          Create Dictionary       title=Plano Nacional      duration=12     price=19.99     total=R$ 239,88

    Insert Plan                      ${plan}  
    Go To Plans
    Search Plan By Title             ${plan.title}
    Request Removal By Reference     ${plan.title}
    Confirm Removal Register

    Toast Should Be                  Plano removido com sucesso
    Element Should Not Visible       ${plan.title} 

    [Teardown]      Thinking And Take Screenshot        2   
    
Cenário: Desistir da Exclusão
     &{plan}          Create Dictionary       title=Plano Nacional      duration=12     price=19.99     total=R$ 239,88

    Insert Plan                      ${plan}  
    Go To Plans
    Search Plan By Title             ${plan.title}
    Request Removal By Reference     ${plan.title}
    Cancel Removel

    Element Should Be Visible        ${plan.title} 

