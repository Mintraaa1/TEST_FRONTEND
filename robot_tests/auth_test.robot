*** Settings ***
Library    SeleniumLibrary
Library    String

Suite Setup       Open Browser To Register Page
Suite Teardown    Close Browser
Test Teardown     Capture Page Screenshot    ./screenshots/${TEST NAME}.png

*** Variables ***
${BROWSER}        chrome
${BASE_URL}       http://localhost:5173
${REGISTER_URL}   ${BASE_URL}/register
${LOGIN_URL}      ${BASE_URL}/login
${PASSWORD}       Test1234
${NEW_EMAIL}      NONE

*** Keywords ***
Open Browser To Register Page
    Open Browser    ${REGISTER_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    20s

Generate Random Email
    ${rand}=    Generate Random String    5    [LETTERS]
    ${email}=   Set Variable    robotuser${rand}@example.com
    RETURN    ${email}

*** Test Cases ***
Register New User (Success)
    ${email}=    Generate Random Email
    Set Suite Variable    ${NEW_EMAIL}    ${email}
    Wait Until Element Is Visible    id=name    20s
    Input Text    id=name    Robot User
    Input Text    id=phone   0123456789
    Input Text    id=email   ${email}
    Input Text    id=password    ${PASSWORD}
    Input Text    id=confirmPassword    ${PASSWORD}
    Click Button    xpath=//button[contains(text(),"ลงทะเบียน")]
    Wait Until Page Contains    ลงทะเบียนสำเร็จ    timeout=15s
    Wait Until Location Contains    /login    15s
    Page Should Contain    เข้าสู่ระบบ

Login With Registered User (Success)
    Go To    ${LOGIN_URL}
    Wait Until Element Is Visible    id=email    20s
    Input Text    id=email    ${NEW_EMAIL}
    Input Text    id=password    ${PASSWORD}
    Click Button    xpath=//button[contains(text(),"เข้าสู่ระบบ")]
    Wait Until Page Contains Element    xpath=//div[contains(text(),"เข้าสู่ระบบสำเร็จ")]    20s
    Wait Until Location Is    ${BASE_URL}/    15s
