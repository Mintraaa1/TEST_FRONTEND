*** Settings ***
Library    RequestsLibrary

*** Variables ***
${API_URL}    http://localhost:5000/api

*** Test Cases ***
Logout Clears Token (Success)
    Create Session    api    ${API_URL}
    ${body}=    Create Dictionary    email=test@example.com    password=Test1234
    ${login}=    Post Request    api    /user/login    json=${body}
    ${cookies}=    Set Variable    ${login.cookies}
    ${logout}=    Post Request    api    /user/logout    cookies=${cookies}
    Should Be Equal As Integers    ${logout.status_code}    200
    Should Contain    ${logout.text}    Logged out successfully
