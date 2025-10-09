*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    http://localhost:5173/login

*** Test Cases ***
Login With Valid User
    Open Browser    ${BASE_URL}    chrome
    Wait Until Element Is Visible    id=email    10s
    Input Text    id=email    test@example.com
    Input Text    id=password    Test1234
    Click Button    xpath=//button[contains(text(),"เข้าสู่ระบบ")]
    Wait Until Location Contains    /    10s
    [Teardown]    Close Browser

Login With Wrong Password
    Open Browser    ${BASE_URL}    chrome
    Wait Until Element Is Visible    id=email    10s
    Input Text    id=email    test@example.com
    Input Text    id=password    WrongPass123
    Click Button    xpath=//button[contains(text(),"เข้าสู่ระบบ")]
    Sleep    1s
    ${found}=    Run Keyword And Return Status    Wait Until Page Contains    Invalid email or password    5s
    IF    not ${found}
        Wait Until Page Contains    อีเมลหรือรหัสผ่านไม่ถูกต้อง    5s
    END
    [Teardown]    Close Browser
