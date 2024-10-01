*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${URL}    https://beahub-web-v1006.devcaprover.nexlesoft.com/
${USERNAME_ELE}    id=horizontal_login_username
${PASSWORD_ELE}    id=horizontal_login_password
${LOGIN_BTN}    //*[@type="submit"]
${USERNAME_1}    merchantowner
${PASSWORD_1}    12345678
${PROFILE}    //*[@class='square']
${LOG_OUT}    xpath=//span[text()='Log out']
${LOGIN_FORM}    //*[@class='ant-card-body']
*** Test Cases ***
dddd
    Open Browser    ${URL}    chrome
    Maximize Browser Window
        # Nhập username và password
    Input Text    ${USERNAME_ELE}    ${USERNAME_1}
    Input Text    ${PASSWORD_ELE}    ${PASSWORD_1}
        # Nhấn nút đăng nhập
    Click Button  ${LOGIN_BTN}
  # Chờ trang chủ tải xong
    Wait Until Element Is Visible    ${PROFILE}    timeout=10s

    # Nhấn vào biểu tượng Profile
    Click Element    ${PROFILE}

    # Chờ menu dropdown của profile hiển thị
    Wait Until Element Is Visible    ${LOG_OUT}    timeout=5s

    # Nhấn vào nút Log out
    Click Element    ${LOG_OUT}

    # Xác minh rằng người dùng đã bị đăng xuất thành công (ví dụ: trang đăng nhập xuất hiện)
    Wait Until Element Is Visible    ${LOGIN_FORM}    timeout=10s
    Page Should Contain Element    ${LOGIN_FORM}

    # Đóng trình duyệt sau khi kiểm tra xong
    [Teardown]    Close Browser