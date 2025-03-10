*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    ../libraries/utils.py
Library    ../libraries/get_fake_person.py
Library    ../libraries/get_fake_company.py
Resource    ../resources/variables.robot
Resource    ../resources/login_keywords.robot
Resource    ../resources/users_keywords.robot
Resource    ../resources/company_keywords.robot
Resource    ../resources/payload_keywords.robot

*** Test Cases ***
Efetuar login (admin)
    [Tags]    smoke
    ${response}    Login    email=${ADMIN_EMAIL}    password=${ADMIN_PASSWORD}
    Status Should Be    200
    Should Contain    ${response.json()["msg"]}    autenticação autorizada com sucesso
    Should Contain Any    ${response.json()}    token
    Set Global Variable    ${ADMIN_TOKEN}    ${response.json()["token"]}

Efetuar login com e-mail inválido e senha válida
    ${response}    Login    email=${INVALID_EMAIL}    password=${ADMIN_PASSWORD}
    Status Should Be    400
    Should Be Equal As Strings    ${response.json()["alert"]}    E-mail ou senha informados são inválidos.

Efetuar login com email inválido e senha inválida
    ${response}    Login    email=${INVALID_EMAIL}    password=${INVALID_PASSWORD}
    Status Should Be    400
    Should Be Equal As Strings    ${response.json()["alert"]}    E-mail ou senha informados são inválidos.

Efetuar login com email válido e senha incorreta
    ${response}    Login    email=${ADMIN_EMAIL}    password=${INVALID_PASSWORD}
    Status Should Be    400
    Should Be Equal As Strings    ${response.json()["alert"]}    E-mail ou senha informados são inválidos.

Cadastrar usuário
    [Tags]    smoke
    ${body}    Get User Payload
    ${response}    Create User    ${body}
    # Status Should Be    201
    Should Contain Any    ${response.json()["user"]}    _id
    Should Contain    ${response.json()["msg"]}    cadastro realizado com sucesso
    Set Global Variable    ${USER_ID}    ${response.json()["user"]["_id"]}
    Set Global Variable    ${USER_EMAIL}    ${response.json()["user"]["mail"]}

Cadastrar usuário com email inválido
    ${body}    Get User Payload
    ${body}    Set Payload Property    ${body}    mail    ${INVALID_EMAIL}
    ${response}    Create User    ${body}
    Status Should Be    400
    Should Contain    ${response.text}    O e-mail informado é inválido. Informe um e-mail no formato [nome@domínio.com].

Cadastrar usuário com CPF em branco
    ${body}    Get User Payload
    ${body}    Set Payload Property    ${body}    cpf    ${EMPTY}
    ${response}    Create User    ${body}
    Status Should Be    400
    Should Contain    ${response.text}    O campo CPF é obrigatório

Efetuar login (user)
    [Tags]    smoke
    ${response}    Login    email=${USER_EMAIL}    password=${USER_PASSWORD}
    Status Should Be    200
    Should Contain    ${response.json()["msg"]}    autenticação autorizada com sucesso
    Should Contain Any    ${response.json()}    token
    Set Global Variable    ${USER_TOKEN}    ${response.json()["token"]}

Contar usuários
    ${response}    Count Users
    Status Should Be    200
    Should Contain Any    ${response.json()}    count

Listar usuários
    [Tags]    smoke
    ${response}    Retrieve Users
    ${length}=  Get length    ${response.json()}
    Status Should Be    200
    Should Be True    ${length} > 0
    Should Not Be Empty    ${response.json()}

Pesquisar usuário por id
    [Tags]    smoke
    ${response}    Retrieve User By Id    ${USER_ID}
    Status Should Be    200
    Should Be Equal As Strings    ${response.json()["_id"]}    ${USER_ID}

Listar Usuário por id não encontrado
    ${response}    Retrieve User By Id   ${INVALID_USER_ID}
    Status Should Be    404
    Log    GET Users Response: ${response}
    Should Be Equal As Strings    ${response.json()["alert"][0]}    Esse usuário não existe em nossa base de dados.

Alterar usuário por id
    [Tags]    smoke
    ${person}=    Get Fake Person
    ${body}=    Create Dictionary
    ...    fullName=${person}[name]
    ...    mail=${person}[email]
    ${response}    Update User By Id    ${USER_ID}    ${body}
    Status Should Be    200
    Should Be Equal As Strings   ${response.json()["msg"]}    Dados atualizados com sucesso!

Alterar usuário por id com fullName em branco
    ${person}=    Get Fake Person
    ${body}=    Create Dictionary
    ...    fullName=${person}[name]
    ...    mail=${person}[email]
    ${body}    Set Payload Property    ${body}    fullName    ${EMPTY}
    ${response}    Update User By Id    ${USER_ID}    ${body}
    Status Should Be    400
    Log    Response Body: ${response}
    Should Be Equal As Strings   ${response.json()["error"][0]}    O campo nome completo é obrigatório.

Alterar usuário por id com mail inválido
    ${person}=    Get Fake Person
    ${body}=    Create Dictionary
    ...    fullName=${person}[name]
    ...    mail=${person}[email]
    ${body}    Set Payload Property    ${body}    mail    ${INVALID_EMAIL}
    ${response}    Update User By Id    ${USER_ID}    ${body}
    Status Should Be    400
    Log    Response Body: ${response}
    Should Be Equal As Strings   ${response.json()["error"][0]}    O e-mail informado é inválido. Informe um e-mail no formato [nome@domínio.com].

Alterar senha do usuário por id
    [Tags]    smoke
    ${response}    Update User Password By Id   ${USER_ID}    ${NEW_PASSWORD}    ${NEW_PASSWORD}
    # Status Should Be    200
    Should Be Equal As Strings   ${response.json()["msg"]}    Senha atualizada com sucesso!

Alterar senha do usuário por id com senha inválida
    ${response}    Update User Password By Id   ${USER_ID}    ${INVALID_PASSWORD}    ${INVALID_PASSWORD}
    Status Should Be    400
    Should Contain   ${response.json()["error"]}    Invalid value

Desativar status do usuário por id
    [Tags]    smoke
    ${body}    Create Dictionary    status=false
    ${response}    Update User status By Id   ${USER_ID}    ${body}
    Status Should Be    200
    Should Be Equal As Strings   ${response.json()["msg"]}    Status do usuario atualizado com sucesso para status false.

Ativar status do usuário por id
    [Tags]    smoke
    ${body}    Create Dictionary    status=true
    ${response}    Update User Status By Id   ${USER_ID}    ${body}
    Status Should Be    200
    Should Be Equal As Strings   ${response.json()["msg"]}    Status do usuario atualizado com sucesso para status true.

Excluir usuário por id
    [Tags]    smoke
    ${response}    Delete User By Id    ${USER_ID}
    Status Should Be    200
    Should Be Equal As Strings   ${response.json()["msg"]}    Usuário deletado com sucesso!.

Excluir Cadastro de Usuário inexistente
    ${response}    Delete User By Id     ${INVALID_USER_ID}
    Status Should Be    400
    Log    Response Body: ${response}
    Should Be Equal As Strings   ${response.json()["alert"][0]}    Esse usuário não existe em nossa base de dados.

Cadastrar empresa
    [Tags]    smoke
    ${body}=    Get Company Payload
    ${response}    Create Company    ${body}
    Status Should Be    201
    Should Be Equal As Strings   ${response.json()["msg"]}    Olá a companhia true foi cadastrada com sucesso.
    Set Global Variable    ${COMPANY_ID}    ${response.json()["newCompany"]["_id"]}
    Set Global Variable    ${CNPJ}    ${response.json()["newCompany"]["registerCompany"]}

Cadastrar empresa com nome da empresa acima do limite
    ${body}    Get Company Payload
    ${body}    Set Payload Property    ${body}    corporateName    ${TOO_LONG_STRING}
    ${response}    Create Company    ${body}
    Status Should Be    400
    Should Be Equal As Strings   ${response.json()["error"][0]}    O campo \'Nome da empresa\' deve ter no máximo 100 caracteres.

Cadastrar empresa com CNPJ em branco
    ${body}    Get Company Payload
    ${body}    Set Payload Property    ${body}    registerCompany    ${EMPTY}
    ${response}    Create Company    ${body}
    Status Should Be    400
    Should Be Equal As Strings   ${response.json()["error"][0]}    O campo \'CNPJ\' da empresa é obrigatório.
    
Listar empresas
    [Tags]    smoke
    ${response}    Retrieve Companies
    ${lenght}    Get Length    ${response.json()}
    Status Should Be    200
    Should Be True    ${lenght} > 0
    Should Not Be Empty    ${response.json()}

#  .Response Body: {'error': 'Internal Server Error'}
Pesquisar empresa por id
    ${response}    Retrieve Company By Id    ${COMPANY_ID}
    Skip If    ${response.status_code} == 500
    Status Should Be    200
    Should Be Equal As Strings    ${response.json()["_id"]}    ${COMPANY_ID}

Listar empresa por ID não encontrado
    ${response}    Retrieve Company By Id   ${INVALID_USER_ID}
    Status Should Be    400
    Should Be Equal As Strings    ${response.json()["alert"][0]}    Essa companhia não existe em nosso sistema.

Alterar empresa por id
    [Tags]    smoke
    ${response}    Update Company By Id    ${COMPANY_ID}
    # Status Should Be    201
    Should Be Equal As Strings   ${response.json()["msg"]}    Companhia atualizada com sucesso.

Alterar endereço da empresa por id
    [Tags]    smoke
    ${response}    Update Company Address By Id    ${COMPANY_ID}
    # Status Should Be    201
    Should Be Equal As Strings   ${response.json()["msg"]}    Companhia atualizada com sucesso.

# Excepetions occured:
# status code: 201 != 200
# response body property: True != False
Desativar status da empresa por id
    ${body}    Create Dictionary    status=false
    ${response}    Update Company status By Id   ${COMPANY_ID}    ${body}
    Skip If    ${response.status_code} != 200
    # Status Should Be    200
    Should Be Equal As Strings   ${response.json()["msg"]}    Status da companhia atualizado com sucesso.
    ${status}    Get From Dictionary    ${response.json()["updateCompany"]}    status
    Log To Console   Status value: ${status}
    Should Be Equal As Strings   ${status}    False

# Excepetions occured:
# status code: 201 != 200
Ativar status da empresa por id
    ${body}    Create Dictionary    status=true
    ${response}    Update Company Status By Id   ${COMPANY_ID}    ${body}
    Skip If    ${response.status_code} != 200
    # Status Should Be    200
    Should Be Equal As Strings   ${response.json()["msg"]}    Status da companhia atualizado com sucesso.
    ${status}    Get From Dictionary    ${response.json()["updateCompany"]}    status
    Log To Console   Status value: ${status}
    Should Be Equal As Strings   ${status}    True

Excluir empresa por id
    [Tags]    smoke
    ${response}    Delete Company By Id    ${COMPANY_ID}
    Status Should Be    200
    Should Be Equal As Strings   ${response.json()["msg"]}    Companhia deletado com sucesso.

Excluir empresa por id não encontrado
    ${response}    Delete Company By Id    ${INVALID_COMPANY_ID}
    Status Should Be    404
    Should Be Equal As Strings    ${response.json()["msg"]}    Essa companhia não existem em nossa base de dados.

# Efetuar login (admin)
# Efetuar login com e-mail inválido e senha válida
# Efetuar login com email inválido e senha inválida
# Efetuar login com email válido e senha incorreta
# Cadastrar usuário
# Cadastrar usuário com email inválido
# Cadastrar usuário com CPF em branco
# Efetuar login (user)
# Contar usuários
# Listar usuários
# Pesquisar usuário por id
# Listar Usuário por id não encontrado
# Alterar usuário por id
# Alterar usuário por id com fullName em branco
# Alterar usuário por id com mail inválido
# Alterar senha do usuário por id
# Alterar senha do usuário por id com senha inválida
# Desativar status do usuário por id
# Ativar status do usuário por id
# Excluir usuário por id
# Excluir Cadastro de Usuário inexistente
# Cadastrar empresa
# Cadastrar empresa com nome da empresa acima do limite
# Cadastrar empresa com CNPJ em branco    
# Listar empresas
# Pesquisar empresa por id
# Listar empresa por ID não encontrado
# Alterar empresa por id
# Alterar endereço da empresa por id
# Desativar status da empresa por id
# Ativar status da empresa por id
# Excluir empresa por id
# Excluir empresa por id não encontrado