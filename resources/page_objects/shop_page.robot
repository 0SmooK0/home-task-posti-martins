*** Settings ***
Resource          ../common_resources.robot

*** Variables ***
${SHOP_PAGE}      https://shop.posti.fi/en

*** Keywords ***
Posti Shop Page is open
    Open Browser    ${SHOP_PAGE}    ${BROWSER}
    Set Window Size    1920    1080
    Wait Until Page Contains Element    xpath=//a[@data-testid='cart-button']   10

A single product worth below 45EUR is added to cart
    # TODO: Need to make the amount not hard coded but that means need to add more complex logic for which item to pick in the store so leaving it for now.
    Add Newest Stamp to the cart
    
Add Newest Stamp to the cart
    # assumes that new stamps will always cost around 23EUR and will be at the top of the page
    Click first Add to Cart button in the page

The customer goes to Shop Page and adds "${prod_type}" product type to the cart
    # TODO: Maybe make this and other steps more usable for other localisations than English by using more universal locator or link map
    ${formatted_prod_type}=    Evaluate    '${prod_type}'.lower().replace(' ', '-')
    Wait Until Element Is Visible    xpath=//a[@href='/en/category/${formatted_prod_type}']
    Click Element    xpath=//a[@href='/en/category/${formatted_prod_type}']
    Click first Add to Cart button in the page
    
Click first Add to Cart button in the page
    Wait Until Page Contains Element   xpath=//button[starts-with(@data-testid, 'add-')]
    Scroll Element Into View   xpath=//button[starts-with(@data-testid, 'add-')]
    Wait Until Element Is Enabled    xpath=//button[starts-with(@data-testid, 'add-')]
    Click Element    xpath=//button[starts-with(@data-testid, 'add-')]