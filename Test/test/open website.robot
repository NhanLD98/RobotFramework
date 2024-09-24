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
    
    # Xác minh login thành công
    Page Should Contain Element  //*[@class="ant-menu-item ant-menu-item-selected"]
    Sleep    10
    Close Browser
