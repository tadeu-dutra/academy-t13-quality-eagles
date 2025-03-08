*** Keywords ***
Create User
    [Documentation]    Users: POST /api/user
    [Arguments]    ${body}
    Log To Console    Request Body: ${body}
    ${response}=    POST On Session    alias=eagles    url=/user/?token=${ADMIN_TOKEN}    json=${body}    expected_status=any
    Log To Console    Response Body: ${response.text}
    RETURN    ${response}

Count Users
    [Documentation]    Users: GET /api/user/count
    ${response}=    GET On Session    alias=eagles    url=/user/count/?token=${USER_TOKEN}   expected_status=any
    Log To Console    Response Body: ${response.text}
    RETURN    ${response}

Retrieve Users
    [Documentation]    Users: GET /api/user
    ${response}=    GET On Session    alias=eagles    url=/user/?token=${USER_TOKEN}   expected_status=any
    RETURN    ${response}

Retrieve User By Id
    [Documentation]    Users: GET /api/user/{id}
    [Arguments]    ${USER_ID}
    ${response}=    GET On Session    alias=eagles    url=/user/${USER_ID}?token=${USER_TOKEN}   expected_status=any
    Log To Console    Response Body: ${response.text}
    RETURN    ${response}

Update User Password By Id
    [Documentation]    Users: PUT /api/user/password/{id}
    [Arguments]    ${USER_ID}    ${password}    ${confirmPassword}
    ${body}=    Create Dictionary
    ...    password=${password}
    ...    confirmPassword=${confirmPassword}
    Log To Console    Request Body: ${body}
    ${response}=    PUT On Session    alias=eagles    url=/user/password/${USER_ID}/?token=${USER_TOKEN}   expected_status=any    json=${body}
    Log To Console    Response Body: ${response.text}
    RETURN    ${response}

Update User By Id
    [Documentation]    Users: PUT /api/user/{id}
    [Arguments]    ${USER_ID}    ${body}
    Log To Console    Request Body: ${body}
    ${response}=    PUT On Session    alias=eagles    url=/user/${USER_ID}/?token=${USER_TOKEN}   expected_status=any    json=${body}
    Log To Console    Response Body: ${response.text}
    RETURN    ${response}

Update User Status By Id
    [Documentation]    Users: PUT /api/user/status/{id}
    [Arguments]    ${USER_ID}    ${body}
    Log To Console    Request Body: ${body}
    ${response}=    PUT On Session    alias=eagles    url=/user/status/${USER_ID}/?token=${ADMIN_TOKEN}   expected_status=any    json=${body}
    Log To Console    Response Body: ${response.text}
    RETURN    ${response}

Delete User By Id
    [Documentation]    Users: DELETE /api/user/{id}
    [Arguments]    ${USER_ID}
    ${response}=    DELETE On Session    alias=eagles    url=/user/${USER_ID}/?token=${ADMIN_TOKEN}   expected_status=any
    Log To Console    Response Body: ${response.text}
    RETURN    ${response}

# Create User
# Count Users
# Retrieve Users
# Retrieve User By Id
# Update User Password By Id
# Update User By Id
# Update User Status By Id
# Delete User By Id