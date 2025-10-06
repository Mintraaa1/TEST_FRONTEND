*** Settings ***
Library    SeleniumLibrary
Library    String

Suite Setup       Open Browser To Register Page
Suite Teardown    Close Browser
Test Teardown     Capture Page Screenshot    # ถ่าย screenshot อัตโนมัติถ้า fail

*** Variables ***
${BROWSER}        chrome
${BASE_URL}       http://localhost:5173
${REGISTER_URL}   ${BASE_URL}/register
${LOGIN_URL}      ${BASE_URL}/login

${NEW_EMAIL}      NONE
${PASSWORD}       Test1234

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
    [Documentation]    ✅ สมัครสมาชิกใหม่สำเร็จ → ต้อง redirect ไปหน้า Login
    ${email}=    Generate Random Email
    Set Suite Variable    ${NEW_EMAIL}    ${email}
    Wait Until Element Is Visible    id=name    20s
    Input Text    id=name    Robot User
    Input Text    id=phone   0123456789
    Input Text    id=email   ${email}
    Input Text    id=password    ${PASSWORD}
    Input Text    id=confirmPassword    ${PASSWORD}
    Click Button    xpath=//button[contains(text(),"ลงทะเบียน")]
    Wait Until Location Contains    /login    20s
    Page Should Contain    เข้าสู่ระบบ

Register Existing User (Fail)
    [Documentation]    ❌ สมัครซ้ำ ต้องไม่สำเร็จ
    Go To    ${REGISTER_URL}
    Wait Until Element Is Visible    id=name    20s
    Input Text    id=name    Robot User
    Input Text    id=phone   0123456789
    Input Text    id=email   ${NEW_EMAIL}
    Input Text    id=password    ${PASSWORD}
    Input Text    id=confirmPassword    ${PASSWORD}
    Click Button    xpath=//button[contains(text(),"ลงทะเบียน")]
    Wait Until Page Contains    ลงทะเบียนไม่สำเร็จ    timeout=20s

Login With Registered User (Success)
    [Documentation]    ✅ Login สำเร็จ → ต้อง redirect ไปหน้า Home และเจอ "ออกจากระบบ"
    Go To    ${LOGIN_URL}
    Wait Until Element Is Visible    id=email    20s
    Input Text    id=email    ${NEW_EMAIL}
    Input Text    id=password    ${PASSWORD}
    Click Button    xpath=//button[contains(text(),"เข้าสู่ระบบ")]
    Wait Until Location Is    ${BASE_URL}/    20s
    # คลิกไอคอน user มุมขวาบน
    Click Element    xpath=//button//*[name()="svg" and contains(@class,"lucide-user")]
    Wait Until Page Contains    ออกจากระบบ    timeout=10s

Login With Wrong Password (Fail)
    [Documentation]    ❌ Login ไม่สำเร็จ (ใส่รหัสผิด)
    Go To    ${LOGIN_URL}
    Wait Until Element Is Visible    id=email    20s
    Input Text    id=email    ${NEW_EMAIL}
    Input Text    id=password    WrongPass123
    Click Button    xpath=//button[contains(text(),"เข้าสู่ระบบ")]
    Wait Until Page Contains    ไม่ถูกต้อง    timeout=20s
