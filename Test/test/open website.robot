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
${ENTER_USERNAME}    Please enter Username!
${ENTER_PASSWORD}    Please enter password!
${INVALID_USERNAME}    123abc                 # Thay bằng username hợp lệ
${INVALID_PASSWORD}   12345678           # Thay bằng password hợp lệ
${TOAST_MSG}    css=.ant-notification-notice-message
${TOAST_MSG_DES}   css=.ant-notification-notice-description
${TOAST_TEXT}   Login was failure             # Nội dung thông báo toast
${TOAST_TEXT_DES}    Username or Password is incorrect.
*** Test Cases ***
Login To Website
    # TC1: log in with empty user name and password
    Open Browser    ${URL}    chrome
    Maximize Browser Window
        # Nhập username và password
    Input Text    ${USERNAME_ELE}    ${EMPTY}
    Input Text    ${PASSWORD_ELE}    ${EMPTY}
        # Nhấn nút đăng nhập
    Click Button   ${LOGIN_BTN}
        # Kiểm tra thông báo lỗi cho username trống
    Page Should Contain    ${ENTER_USERNAME}
        # Kiểm tra thông báo lỗi cho password trống
    Page Should Contain    ${ENTER_PASSWORD}
    Close Browser
    #TC2: Empty with empty password
    Open Browser    ${URL}    chrome
    Maximize Browser Window
        # Nhập username và password
    Input Text    ${USERNAME_ELE}    ${USERNAME_1}
    Input Text    ${PASSWORD_ELE}    ${EMPTY}
        # Nhấn nút đăng nhập
    Click Button   ${LOGIN_BTN}
        # Kiểm tra thông báo lỗi cho password trống
    Page Should Contain    ${ENTER_PASSWORD}
    Close Browser
    #TC3: Empty with empty username
    Open Browser    ${URL}    chrome
    Maximize Browser Window
        # Nhập username và password
    Input Text    ${USERNAME_ELE}    ${EMPTY}
    Input Text    ${PASSWORD_ELE}    ${PASSWORD_1}
        # Nhấn nút đăng nhập
    Click Button   ${LOGIN_BTN}
        # Kiểm tra thông báo lỗi cho password trống
    Page Should Contain    ${ENTER_USERNAME}
    Close Browser
    #TC4: Login with invalid account
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
    #TC_5: Login successfully
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

    Close Browser
