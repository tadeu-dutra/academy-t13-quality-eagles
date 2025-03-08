*** Keywords ***
Create Company
    [Documentation]    Company: POST /api/company
    [Arguments]    ${body}
    Log To Console    Request Body: ${body}
    ${response}=    POST On Session    alias=eagles    url=/company/?token=${USER_TOKEN}    json=${body}    expected_status=any
    Log To Console    Response Body: ${response}
    RETURN    ${response}

Retrieve Companies
    [Documentation]    Company: GET /api/company
    ${response}=    GET On Session    alias=eagles    url=/company/?token=${USER_TOKEN}   expected_status=any
    RETURN    ${response}

Retrieve Company By Id
    [Documentation]    Company: GET /api/company/{id}
    [Arguments]    ${COMPANY_ID}
    ${response}=    GET On Session    alias=eagles    url=/company/${COMPANY_ID}?token=${ADMIN_TOKEN}   expected_status=any
    Log To Console    Response Body: ${response}
    RETURN    ${response}

Update Company By Id
    [Documentation]    Company: GET /api/company/{id}
    [Arguments]    ${COMPANY_ID}
    ${body}=    Get Company Payload For Update
    Log To Console    Request Body: ${body}
    ${response}=    PUT On Session    alias=eagles    url=/company/${COMPANY_ID}/?token=${USER_TOKEN}    json=${body}    expected_status=any
    Log To Console    Response Body: ${response}
    RETURN    ${response}

Update Company Address By Id
    [Documentation]    Company: GET /api/company/address/{id}
    [Arguments]    ${COMPANY_ID}
    ${body}=    Get Company Payload
    ${new_address_data}    Get Address Payload For Update
    ${body}=    Set Payload Property    ${body}    address    ${new_address_data}
    Log To Console    Request Body: ${body}
    ${response}=    PUT On Session    alias=eagles    url=/company/${COMPANY_ID}/?token=${USER_TOKEN}    json=${body}    expected_status=any
    Log To Console    Response Body: ${response}
    RETURN    ${response}

Update Company Status By Id
    [Documentation]    Users: PUT /api/company/status/{id}
    [Arguments]    ${USER_ID}    ${body}
    Log To Console    Request Body: ${body}
    ${response}=    PUT On Session    alias=eagles    url=/company/status/${COMPANY_ID}/?token=${ADMIN_TOKEN}   expected_status=any    json=${body}
    Log To Console    Response Body: ${response.text}
    RETURN    ${response}

Delete Company By Id
    [Arguments]    ${COMPANY_ID}
    ${response}=    DELETE On Session    alias=eagles    url=/company/${COMPANY_ID}/?token=${USER_TOKEN}   expected_status=any
    Log To Console    Response Body: ${response}
    RETURN    ${response}

# Create Company
# Retrieve Companies
# Retrieve Company By Id
# Update Company By Id
# Update Company Address By Id
# Update Company Status By Id
# Delete Company By Id