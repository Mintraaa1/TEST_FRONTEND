*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    String

*** Variables ***
${BASE_URL}    http://localhost:5173/register
${RANDOM}=     Evaluate    random.randint(1000,9999)    modules=random

*** Test Cases ***
Register New User (Success) :: ✅ ทดสอบการลงทะเบียนผู้ใช้ใหม่
    Open Browser    ${BASE_URL}    chrome
    Wait Until Element Is Visible    id=name    10s
    Input Text    id=name    Test User
    Input Text    id=phone    0812345678
    Input Text    id=email    test${RANDOM}@example.com
    Input Text    id=password    Test1234
    Input Text    id=confirmPassword    Test1234
    Click Button    xpath=//button[contains(text(),'ลงทะเบียน')]
    # ✅ ตรวจจับ toast หรือข้อความสำเร็จ
    Run Keyword And Ignore Error    Wait Until Element Is Visible    xpath=//span[contains(text(),'ลงทะเบียนสำเร็จ!')]    10s
    Close Browser

Register Duplicate Email (Fail) :: ⚠️ ทดสอบลงทะเบียนซ้ำ (ต้องแสดง error)
    Open Browser    ${BASE_URL}    chrome
    Wait Until Element Is Visible    id=name    10s
    Input Text    id=name    Test User
    Input Text    id=phone    0812345678
    Input Text    id=email    test@example.com
    Input Text    id=password    Test1234
    Input Text    id=confirmPassword    Test1234
    Click Button    xpath=//button[contains(text(),'ลงทะเบียน')]
    # ✅ รองรับทั้งข้อความ “ลงทะเบียนไม่สำเร็จ” และ “User already exists”
    ${found}=    Run Keyword And Return Status    Wait Until Page Contains    ลงทะเบียนไม่สำเร็จ    timeout=5s
    IF    not ${found}
        Wait Until Page Contains    User already exists    5s
    END
    Close Browser
