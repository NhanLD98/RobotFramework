*** Test Cases ***
*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${URL}    https://beahub-web-v1006.devcaprover.nexlesoft.com/
${USERNAME_ELE}    id=horizontal_login_username
${PASSWORD_ELE}    id=horizontal_login_password
${LOGIN_BTN}    //*[@type="submit"]
${USERNAME_1}    merchantowner
${PASSWORD_1}    12345678
${FORGOT_PASSWORD}    //SPAN[text()='Forgot password?']
${ACCOUNT_FORGOT_PWD}    //*[@id ='username']
${BUTTON_SEND}    //*[@class='ant-btn save-button ant-btn-primary']
${FORGOT_PWD_SUCCESS}    //*[@class='ant-notification-notice-message']
${TOAST_FORGOT_TEXT}    The system has sent the password recovery link to your email address
*** Test Cases ***
dddd
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    # Chờ trang chủ tải xong
    Wait Until Element Is Visible    ${FORGOT_PASSWORD}   10

    # Nhấn vào biểu tượng Profile
    Click Element    ${FORGOT_PASSWORD}
    Input Text     ${ACCOUNT_FORGOT_PWD}    ${USERNAME_1}
    Click Button    ${BUTTON_SEND}
    # Chờ toast message xuất hiện
    Wait Until Page Contains Element    ${FORGOT_PWD_SUCCESS}    10s

    # Kiểm tra nội dung của toast messages
    Element Text Should Be    ${FORGOT_PWD_SUCCESS}     ${TOAST_FORGOT_TEXT}

    # Đóng trình duyệt sau khi kiểm tra xong
    [Teardown]    Close Browser