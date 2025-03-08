*** Keywords ***
Create API Session
    [Documentation]    Create a Session
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=eagles    url=${BASE_URL}    headers=${headers}    verify=True

Login
    [Documentation]    Auth: POST /api/login
    [Arguments]    ${email}    ${password}
    ${body}    Create Dictionary
    ...    mail=${email}
    ...    password=${password}
    Create API Session
    Log To Console    Request Body: ${body}
    ${response}    POST On Session    alias=eagles    url=/login    json=${body}    expected_status=any
    Log To Console    Response Body: ${response}
    RETURN    ${response}
