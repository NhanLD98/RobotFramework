*** Test Cases ***
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}          https://beahub-web-v1006.devcaprover.nexlesoft.com/
${LOGIN_BTN}    //*[@type="submit"]            # Thay bằng định danh của nút login
${USERNAME_ELE}    id=horizontal_login_username
${PASSWORD_ELE}    id=horizontal_login_password
${INVALID_USERNAME}    NHANLDOZ                # Thay bằng username hợp lệ
${INVALID_PASSWORD}   12345678           # Thay bằng password hợp lệ
${TOAST_MSG}    //div[text()='Login was failure']
${TOAST_MSG_DES}   //div[text()='Username or Password is incorrect.']
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
    Wait Until Page Contains Element    ${TOAST_MSG}    10
    Wait Until Page Contains Element    ${TOAST_MSG_DES}  10
    # Kiểm tra nội dung của toast messages
    Page Should Contain Element   ${TOAST_MSG}    10
    Page Should Contain    ${TOAST_TEXT_DES}    10
    
    # Nếu cần, có thể chờ toast message biến mất
    #Wait Until Element Does Not Contain    ${TOAST_MSG}    ${TOAST_TEXT}    5s
    #Wait Until Element Does Not Contain    ${TOAST_MSG_DES}    ${TOAST_TEXT_DES}    5s
    Close Browser