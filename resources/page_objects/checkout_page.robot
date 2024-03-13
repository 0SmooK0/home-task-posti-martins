*** Settings ***
Resource          ../common_resources.robot
Resource          cart_page.robot

*** Variables ***

*** Keywords ***
Invalid Post Code Should Fail
    [Arguments]    ${postcode}
    Input ${postcode} in the form
    Element Should Be Visible     xpath=//div[contains(@class, 'PostcodeField__PostcodeMessageWrapper')]    5

Valid Post Code Should Pass
    [Arguments]    ${postcode}
    Input ${postcode} in the form
    Element Should Not Be Visible    xpath=//div[contains(@class, 'PostcodeField__PostcodeMessageWrapper')]    5

The Customer has added stamps to the cart and proceeds to checkout
    The Customer already has a single Product below 45EUR in his cart
    Wait Until Page Contains Element   xpath=//button[@data-testid='checkout']
    Scroll Element Into View   xpath=//button[@data-testid='checkout']
    Wait Until Element Is Enabled    xpath=//button[@data-testid='checkout']
    Click Element    xpath=//button[@data-testid='checkout']
    Wait Until Element Is Visible    xpath=//input[@data-testid='billing-postcode-field']    10

Input ${postcode} in the form
    Wait Until Element Is Visible    xpath=//input[@data-testid='billing-postcode-field']    10
    Scroll Element Into View     xpath=//input[@data-testid='billing-postcode-field']
    Input Text    xpath=//input[@data-testid='billing-postcode-field']    ${postcode}