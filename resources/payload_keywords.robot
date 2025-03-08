*** Keywords ***
Get User Payload
    ${person}    Get Fake Person
    ${body}    Create Dictionary
    ...    fullName=${person}[name]
    ...    mail=${person}[email]
    ...    accessProfile=ADMIN
    ...    cpf=${person}[cpf]
    ...    password=${USER_PASSWORD}
    ...    confirmPassword=${USER_PASSWORD}
    RETURN    ${body}

Get User Status Payload For Update
    [Arguments]    ${status}
    ${body}    Create Dictionary
    ...    status=${status}
    RETURN    ${body}

Get Company Payload
    ${company}=    Get Fake Company
    ${body}=    Create Dictionary
    ...    corporateName=${company}[corporateName]
    ...    registerCompany=${company}[registerCompany]
    ...    mail=${company}[mail]
    ...    matriz=${company}[matriz]
    ...    responsibleContact=${company}[responsibleContact]
    ...    telephone=${company}[telephone]
    ...    serviceDescription=${company}[serviceDescription]
    ...    address=${company}[address]
    RETURN    ${body}

Get Company Payload For Update
    ${company}=    Get Fake Company
    ${body}=    Create Dictionary
    ...    corporateName=${company}[corporateName]
    ...    registerCompany=${company}[registerCompany]
    ...    mail=${company}[mail]
    ...    matriz=${company}[matriz]
    ...    responsibleContact=${company}[responsibleContact]
    ...    telephone=${company}[telephone]
    ...    serviceDescription=${company}[serviceDescription]
    RETURN    ${body}

Get Address Payload For Update
    ${company}=    Get Fake Company
    ${body}=    Create Dictionary
    ...    zipCode=${company}[address]\[zipCode]
    ...    city=${company}[address]\[city]
    ...    state=${company}[address]\[state]
    ...    district=${company}[address]\[district]
    ...    street=${company}[address]\[street]
    ...    number=${company}[address]\[number]
    ...    complement=${company}[address]\[complement]
    ...    country=${company}[address]\[country]
    RETURN    ${body}

Set Payload Property
    [Arguments]    ${collection}    ${key}    ${value}
    Set To Dictionary    ${collection}    ${key}=${value}
    RETURN    ${collection}

# Get User Payload
# Get User Status Payload For Update
# Get Company Payload
# Get Company Payload For Update
# Get Address Payload For Update
# Set Payload Property