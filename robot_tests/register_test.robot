*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${BASE_URL}       http://localhost:5173
${REGISTER_URL}   ${BASE_URL}/register
${BROWSER}        chrome
${PASSWORD}       Test1234

*** Test Cases ***
Register Missing Field (Fail)
    Open Browser    ${REGISTER_URL}    ${BROWSER}
    Input Text    id=email    missing@example.com
    Click Button    xpath=//button[contains(text(),"ลงทะเบียน")]
    Wait Until Page Contains Element    xpath=//div[contains(@class,"bg-red")]    10s
    Close Browser

Register Duplicate Email (Fail)
    Open Browser    ${REGISTER_URL}    ${BROWSER}
    Input Text    id=name    Robot User
    Input Text    id=phone   0123456789
    Input Text    id=email   test@example.com
    Input Text    id=password    ${PASSWORD}
    Input Text    id=confirmPassword    ${PASSWORD}
    Click Button    xpath=//button[contains(text(),"ลงทะเบียน")]
    Wait Until Page Contains Element    xpath=//*[contains(text(),"User already exists")]    10s
    Close Browser
