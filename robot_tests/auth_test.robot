*** Settings ***
Library    RequestsLibrary
Library    BuiltIn
Library    Collections
Library    OperatingSystem
Library    String

*** Variables ***
${BASE_URL}    http://localhost:5000/api
${RANDOM}=     Evaluate    random.randint(1000,9999)    modules=random
${NEW_EMAIL}=  Set Variable    test${RANDOM}@example.com
${PASSWORD}    Test1234
${NAME}        Test User
${PHONE}       0812345678

*** Test Cases ***
Register API (Success) :: ✅ ทดสอบการลงทะเบียนผู้ใช้ใหม่ (สำเร็จ)
    Create Session    mysession    ${BASE_URL}
    ${data}=    Create Dictionary    name=${NAME}    phone=${PHONE}    email=${NEW_EMAIL}    password=${PASSWORD}    role=user
    ${response}=    POST On Session    mysession    /user/register    json=${data}
    Log To Console    Register API response: ${response.status_code} ${response.text}
    Should Be Equal As Integers    ${response.status_code}    201

Login API (Success) :: ✅ ทดสอบเข้าสู่ระบบด้วยข้อมูลที่ถูกต้อง
    Create Session    mysession    ${BASE_URL}
    ${data}=    Create Dictionary    email=${NEW_EMAIL}    password=${PASSWORD}
    ${response}=    POST On Session    mysession    /user/login    json=${data}
    Log To Console    Login API response: ${response.status_code} ${response.text}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    email
