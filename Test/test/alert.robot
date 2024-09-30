*** Test Cases ***
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://beahub-web-v1006.devcaprover.nexlesoft.com/
${LOGIN_BTN}    //*[@type="submit"]            # Thay bằng định danh của nút login
${USERNAME_ELE}    id=horizontal_login_username
${PASSWORD_ELE}    id=horizontal_login_password
${INVALID_USERNAME}    123abc                 # Thay bằng username hợp lệ
${INVALID_PASSWORD}   12345678           # Thay bằng password hợp lệ
${TOAST_MSG}    css=.ant-notification-notice-message
${TOAST_MSG_DES}   css=.ant-notification-notice-description
${TOAST_TEXT}   Login was failure             # Nội dung thông báo toast
${TOAST_TEXT_DES}    Username or Password is incorrect.

*** Test Cases ***
TC: Check Toast Message
    Open Browser    ${URL}    chrome
    Maximize Browser Window

    # Nhập username và password hợp lệ
    Input Text    ${USERNAME_ELE}     ${INVALID_USERNAME}
    Input Text    ${PASSWORD_ELE}    ${INVALID_PASSWORD}
    Click Button  ${LOGIN_BTN}

    # Chờ toast message xuất hiện
    Wait Until Page Contains Element    ${TOAST_MSG}    10s
    Wait Until Page Contains Element    ${TOAST_MSG_DES}  10s
    # Kiểm tra nội dung của toast message
    Element Text Should Be    ${TOAST_MSG}    ${TOAST_TEXT}
    Element Text Should Be    ${TOAST_MSG_DES}    ${TOAST_TEXT_DES}

    # Nếu cần, có thể chờ toast message biến mất
    #Wait Until Element Does Not Contain    ${TOAST_MSG}    ${TOAST_TEXT}    5s
    #Wait Until Element Does Not Contain    ${TOAST_MSG_DES}    ${TOAST_TEXT_DES}    5s
    Close Browser