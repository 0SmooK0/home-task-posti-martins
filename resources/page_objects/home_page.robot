*** Settings ***
Resource          ../common_resources.robot

*** Variables ***

${HOME_PAGE}      https://www.posti.fi/en

*** Keywords ***
The Posti home page is open
    Open Browser    ${HOME_PAGE}    ${BROWSER}
    Set Window Size    1920    1080
    Wait Until Element Is Visible    id:posti-fi-navigation  10s

The Customer selects a Stamp and is taken to the Product Page
    Scroll Element Into View   id:send-letters-and-postcards-with-stamps
    Click Element    css=#send-letters-and-postcards-with-stamps .product-blocks .productcard-0-1-15:nth-child(2) .shopping-cart-button
    # TODO: replace css selector with xpath for consistency.
    Switch Window   NEW
    Wait Until Page Contains Element    xpath=//a[@data-testid='cart-button']   10