*** Settings ***
Documentation     This suite contains automated tests that take customer78 to the stamp shop and checks if cart totals as well as delivery fees are accurately calculated based on the information from Shop.Posti.com. These tests fulfill home assignment part "Validate that the total and delivery fees are calculated correctly, also after updating the cart with an additional product."
Resource          ../resources/common_resources.robot
Resource          ../resources/page_objects/home_page.robot
Resource          ../resources/page_objects/cart_page.robot
Resource          ../resources/page_objects/product_page.robot
Test Teardown     Close Browser

*** Test Cases ***

Updating Cart With Additional Same Product And Validate Total And Delivery Fees
    [Documentation]  This test checks that after updating the cart with an addition of the same product from cart page, the total and delivery fees are still calculated correctly. At the time of writing, orders above 45EUR qualify for shipping.
    Given The Customer already has a single Product below 45EUR in his cart
    Then Delivery fee of "${DELIVERY_FEE}" EUR is applied
    When The customer increases amount of the same product exceeding ${MAX_AMOUNT_DELIVERY_FEE} EUR total
    Then Delivery fee of "0" EUR is applied
    And The Subtotal and Total should be calculated relative to the Items in the cart
    When The customer decreases amount of the same product to or below ${MAX_AMOUNT_DELIVERY_FEE} EUR total
    Then Delivery fee of "${DELIVERY_FEE}" EUR is applied
    And The Subtotal and Total should be calculated relative to the Items in the cart

Updating Cart With Additional Different Product And Validate Total And Delivery Fees
    [Documentation]  This test checks that after updating the cart with an addition of a different product from cart page, the total and delivery fees are still calculated correctly..
    Given The Customer already has a single Product below 45EUR in his cart
    When The customer goes to Shop Page and adds "Envelopes" product type to the cart
    Then Delivery fee of "${DELIVERY_FEE}" EUR is applied
    And The Subtotal and Total should be calculated relative to the Items in the cart
    When The customer goes to Shop Page and adds "For Business" product type to the cart
    Then Delivery fee of "0" EUR is applied
    And The Subtotal and Total should be calculated relative to the Items in the cart

