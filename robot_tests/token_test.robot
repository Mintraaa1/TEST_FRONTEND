*** Settings ***
Library           RequestsLibrary
Library           JSONLibrary
Library           Collections

*** Variables ***
${BASE_URL}       http://localhost:5000/api/user
${EMAIL}          robotuser123@example.com
${PASSWORD}       Test1234

*** Test Cases ***
Login And Check Token (Success)
    [Documentation]    ✅ ทดสอบ login แล้วตรวจว่า server ส่ง cookie jwt กลับมาจริง
    Create Session    user    ${BASE_URL}
    ${data}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${resp}=    POST On Session    user    /login    json=${data}    headers=${headers}
    Log    Login response: ${resp.text}
    Should Be Equal As Integers    ${resp.status_code}    200
    Dictionary Should Contain Key    ${resp.cookies}    jwt
