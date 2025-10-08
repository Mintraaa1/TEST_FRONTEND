*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

*** Variables ***
${BASE_URL}    http://localhost:5000/api/user
${EMAIL}       robotuser123@example.com
${PASSWORD}    Test1234

*** Test Cases ***
Get Profile Without Token (Fail)
    [Documentation]    ❌ เรียก /profile โดยไม่แนบ token → ต้องได้ 401
    Create Session    no_token    ${BASE_URL}
    ${resp}=    GET On Session    no_token    /profile
    Log To Console    \nResponse (no token): ${resp.text}
    Should Be Equal As Integers    ${resp.status_code}    401

Get Profile With Token (Success)
    [Documentation]    ✅ Login ก่อน แล้วนำ token ไปเรียก /profile → ต้องได้ 200
    Create Session    login_session    ${BASE_URL}
    ${body}=    Create Dictionary    email=${EMAIL}    password=${PASSWORD}
    ${resp}=    POST On Session    login_session    /login    json=${body}
    Log To Console    \nLogin response: ${resp.text}
    Log To Console    \nLogin cookies: ${resp.cookies}

    ${jwt_cookie}=    Get From Dictionary    ${resp.cookies}    jwt
    Create Session    auth_session    ${BASE_URL}    cookies=${resp.cookies}
    ${profile}=    GET On Session    auth_session    /profile
    Log To Console    \nProfile response: ${profile.text}
    Should Be Equal As Integers    ${profile.status_code}    200
