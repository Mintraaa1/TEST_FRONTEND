*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BASE_URL}       http://localhost:5173
${LOGIN_URL}      ${BASE_URL}/login
${BROWSER}        chrome
${PASSWORD}       Test1234

*** Test Cases ***
Login With Wrong Password (Fail)
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Input Text    id=email    test@example.com
    Input Text    id=password    WrongPass123
    Click Button    xpath=//button[contains(text(),"เข้าสู่ระบบ")]
    Wait Until Page Contains Element    xpath=//*[contains(text(),"Invalid email or password") or contains(text(),"รหัสผ่าน")]    15s
    Close Browser

Login With Nonexistent Email (Fail)
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Input Text    id=email    noone@example.com
    Input Text    id=password    Test1234
    Click Button    xpath=//button[contains(text(),"เข้าสู่ระบบ")]
    Wait Until Page Contains Element    xpath=//*[contains(text(),"Invalid email or password")]    15s
    Close Browser
