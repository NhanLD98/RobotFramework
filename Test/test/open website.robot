*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://beahub-web-v1006.devcaprover.nexlesoft.com/
${USERNAME}    merchantowner
${PASSWORD}    12345678

*** Test Cases ***
Login To Website
    Open Browser    ${URL}    chrome
    Maximize Browser Window

    # Nhập username và password
    Input Text    id=horizontal_login_username    ${USERNAME}
    Input Text    id=horizontal_login_password    ${PASSWORD}

    # Nhấn nút đăng nhập
    Click Button  //*[@class="ant-btn ant-btn-primary"]
    # Chờ đợi trang Dashboard tải xong và kiểm tra sự xuất hiện của văn bản 'Dashboard'
    Wait Until Page Contains    Dashboard    10s
    # Xác minh login thành công
    Page Should Contain   Dashboard
    Close Browser
