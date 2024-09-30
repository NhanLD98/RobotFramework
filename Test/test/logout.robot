*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${URL}    https://beahub-web-v1006.devcaprover.nexlesoft.com/
${USERNAME_ELE}    id=horizontal_login_username
${PASSWORD_ELE}    id=horizontal_login_password
${LOGIN_BTN}    //*[@type="submit"]
${USERNAME_1}    merchantowner
${PASSWORD_1}    12345678
${TEXT_DASHBOARD}    Dashboard
*** Test Cases ***
dddd
    Open Browser    ${URL}    chrome
    Maximize Browser Window
        # Nhập username và password
    Input Text    ${USERNAME_ELE}    ${USERNAME_1}
    Input Text    ${PASSWORD_ELE}    ${PASSWORD_1}
        # Nhấn nút đăng nhập
    Click Button  ${LOGIN_BTN}
        # Chờ đợi trang Dashboard tải xong và kiểm tra sự xuất hiện của văn bản 'Dashboard'
    Wait Until Page Contains    ${TEXT_DASHBOARD}
        # Xác minh login thành công
    Page Should Contain   ${TEXT_DASHBOARD}
    Click Element        css=.square
    Click Element        /html/body/div[3]/div/div/ul/li[4]
    Close Browser