*** Settings ***
Documentation     This suite contains automated tests that take customer from the home page to the stamp shop and checks if cart totals are accurately calculated based on the information from Shop.Posti.com. This suite was developed based on home assignment: "Go to https://www.posti.fi/en and add stamps of your choosing to the cart." 
Resource          ../resources/common_resources.robot
Resource          ../resources/page_objects/home_page.robot
Resource          ../resources/page_objects/cart_page.robot
Resource          ../resources/page_objects/product_page.robot
Test Teardown     Close Browser

*** Test Cases ***
Navigating from home page, add a single stamp to the cart
    [Documentation]  As a Customer navigate from home page, add a single stamp and check if cart totals are calculated correctly for single item
    Given The Posti home page is open
    When The Customer selects a Stamp and is taken to the Product Page
    And The Customer adds The Opened Product to The Cart
    And The Customer opens The Cart
    Then The Subtotal and Total should be calculated relative to the Items in the cart