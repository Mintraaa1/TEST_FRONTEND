*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${BASE_URL}       http://localhost:5000/api/user
${EMAIL}          robotuser123@example.com
${PASSWORD}       Test1234

*** Test Cases ***
Login Should Return JWT
    [Documentation]    ✅ เมื่อเข้าสู่ระบบสำเร็จ ต้องได้ cookie ชื่อ jwt
    Create Session    user    ${BASE_URL}
    ${data}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${resp}=    POST On Session    user    /login    json=${data}    headers=${headers}
    Log To Console    Login cookies: ${resp.cookies}
    Should Be Equal As Integers    ${resp.status_code}    200
    Dictionary Should Contain Key    ${resp.cookies}    jwt
