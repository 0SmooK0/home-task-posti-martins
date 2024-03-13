*** Settings ***
Resource          ../common_resources.robot  # Ensures access to common keywords and settings

*** Variables ***
# Define product page-specific variables here, if any

*** Keywords ***
The Customer adds The Opened Product to The Cart
    Scroll Element Into View    xpath=//button[@data-testid='add-to-cart-button']
    Click Element    xpath=//button[@data-testid='add-to-cart-button']