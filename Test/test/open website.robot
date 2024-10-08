*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${URL}    https://beahub-web-v1006.devcaprover.nexlesoft.com/
${USERNAME_ELE}    id=horizontal_login_username
${PASSWORD_ELE}    id=horizontal_login_password
${LOGIN_BTN}    //button[span[text()='Login']]
${USERNAME_1}    merchantowner
${PASSWORD_1}    12345678
${TEXT_DASHBOARD}    Dashboard
${ENTER_USERNAME}    Please enter Username!
${ENTER_PASSWORD}    Please enter password!
${INVALID_USERNAME}    invalidusername1
${INVALID_PASSWORD}   12345678
${TOAST_ELEMENT}    //div[text()='Login was failure']
${TOAST_ELEMENT_DES}   //div[text()='Username or Password is incorrect.']
${TOAST_TEXT}   Login was failure             # Nội dung thông báo toast
${TOAST_TEXT_DES}    Username or Password is incorrect.
${PROFILE}    //*[@class='square']
${LOG_OUT}    xpath=//span[text()='Log out']
${LOGIN_FORM}    //div[@class='ant-card-body']
${FORGOT_PASSWORD}    //SPAN[text()='Forgot password?']
${ACCOUNT_FORGOT_PWD}    //input[@id='username']
${BUTTON_SEND_FORGOT}    //button[span[text()='Send']]
${TOAST_FORGOT_TEXT}    The system has sent the password recovery link to your email address
*** Test Cases ***
Testcase 1
    # TC1: log in with empty user name and passwords
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
Testcase 2
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
Testcase 3
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
Testcase 4
    #TC4: Login with invalid account
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    # Nhập username và password hợp lệ
    Input Text    ${USERNAME_ELE}     ${INVALID_USERNAME}
    Input Text    ${PASSWORD_ELE}    ${INVALID_PASSWORD}
    Click Button  ${LOGIN_BTN}
    # Chờ toast message xuất hiện
    Wait Until Page Contains Element    ${TOAST_ELEMENT}    10s
    Wait Until Page Contains Element    ${TOAST_ELEMENT_DES}  10s
    # Kiểm tra nội dung của toast message
    Page Should Contain Element     ${TOAST_ELEMENT}
    Page Should Contain Element     ${TOAST_ELEMENT_DES}
    # Nếu cần, có thể chờ toast message biến mất
    #Wait Until Element Does Not Contain    ${TOAST_MSG}    ${TOAST_TEXT}    5s
    Close Browser
Testcase 5
    #TC_5: Login successfullys
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
Testcase 6
    #TC_6: Logout successfully
    Open Browser    ${URL}    chrome
    Maximize Browser Window
        # Nhập username và password
    Input Text    ${USERNAME_ELE}    ${USERNAME_1}
    Input Text    ${PASSWORD_ELE}    ${PASSWORD_1}
    Click Button  ${LOGIN_BTN}
    Wait Until Element Is Visible    ${PROFILE}    timeout=10s
    Click Element    ${PROFILE}
    Wait Until Element Is Visible    ${LOG_OUT}    timeout=5s
    Click Element    ${LOG_OUT}
    Wait Until Element Is Visible    ${LOGIN_FORM}    timeout=10s
    Page Should Contain Element    ${LOGIN_FORM}
    Close Browser
Testcase 7
    #TC7: Forget password with empty account
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${FORGOT_PASSWORD}   timeout=10s
    Click Element    ${FORGOT_PASSWORD}
    Input Text     ${ACCOUNT_FORGOT_PWD}    ${EMPTY}
    Click Button    ${BUTTON_SEND_FORGOT}
    Close Browser
Testcase 8
    #TC8: Forget password with invalid account
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${FORGOT_PASSWORD}   timeout=10s
    Click Element    ${FORGOT_PASSWORD}
    Input Text     ${ACCOUNT_FORGOT_PWD}    ${INVALID_USERNAME}
    Click Button    ${BUTTON_SEND_FORGOT}
    Close Browser
Testcase 9
    #TC9: Forget password with valid account
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${FORGOT_PASSWORD}   timeout=10s
    Click Element    ${FORGOT_PASSWORD}
    Input Text     ${ACCOUNT_FORGOT_PWD}    ${USERNAME_1}
    Click Button    ${BUTTON_SEND_FORGOT}
    Wait Until Page Contains    ${TOAST_FORGOT_TEXT}       10s
    Page should contain      ${TOAST_FORGOT_TEXT}
    Close Browser
