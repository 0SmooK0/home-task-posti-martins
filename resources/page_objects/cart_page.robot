*** Settings ***
Resource          ../common_resources.robot
Resource          shop_page.robot

*** Variables ***
${CART_TOTAL_CALCULATED}

*** Keywords ***
The Customer opens The Cart
    Click Element    xpath=//a[@data-testid='cart-button']
    # TODO: While method below for waiting for cart to reload works in theory, often numbers are still not loaded or spinner does not appear resulting in a failed case and a flaky test run. Need to find a different solution that is not slower.
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'CartTotals__LoaderContainer')]
    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'CartTotals__LoaderContainer')]

The Subtotal and Total should be calculated relative to the Items in the cart 
    Calculate And Verify Cart Item Totals
    Verify Cart Total Calculations Match The Total of Items

# TODO: Need to separate more complex logic of keywords to specific validation keyword file(s) for better readability

Verify Cart Total Calculations Match The Total of Items
    ${cart_subtotal}=    Get Text    xpath=//span[@id='cart-totals-subtotal-value']
    ${cart_subtotal}=    Evaluate    "${cart_subtotal}".replace(u"\u20AC", '').strip()

    ${delivery_fee}=    Get Text    xpath=//span[@id='cart-totals-shipping-value']
    ${delivery_fee}=    Evaluate    "${delivery_fee}".replace(u"\u20AC", '').strip()

    ${total_amount}=    Get Text    xpath=//h3[@id='cart-totals-total-value']
    ${total_amount}=    Evaluate    "${total_amount}".replace(u"\u20AC", '').strip()

    ${cart_subtotal}=    Convert To Number    ${cart_subtotal}
    ${delivery_fee}=    Convert To Number    ${delivery_fee}
    ${total_amount}=    Convert To Number    ${total_amount}
    ${total_without_delivery}=    Evaluate    ${total_amount} - ${delivery_fee}

    Should Be Equal As Numbers    ${cart_subtotal}    ${CART_TOTAL_CALCULATED}
    Should Be Equal As Numbers    ${total_without_delivery}    ${CART_TOTAL_CALCULATED}

Calculate And Verify Cart Item Totals
    # TODO: Couldn't get WebElements list work properly in a loop so the solution is a bit dirty
    ${cart_items}=    Get WebElements    xpath=//ul[starts-with(@class, 'CartItemsList__List')]/li[starts-with(@class, 'CartItemsList__ListItem')]
    ${total_calculated}=    Set Variable    ${0}
    ${length_of_list}=   Get Length    ${cart_items}
    FOR    ${index}    IN RANGE    ${length_of_list}
    ${base_xpath}=    Set Variable    xpath=//ul[starts-with(@class, 'CartItemsList__List')]/li[starts-with(@class, 'CartItemsList__ListItem')][${index + 1}]
    ${unit_price_xpath}=    Set Variable    ${base_xpath}//div[@data-testid='item-price-per-unit']
    ${unit_quantity_xpath}=    Set Variable    ${base_xpath}//select[@data-testid='item-qty-select']
    # TODO: Currently is able to test up to 24 of the same items in the cart as the selection mode changes above 24 and locator at present only points to one below. Need to add logic to test for alternative selector.
    ${total_price_xpath}=    Set Variable    ${base_xpath}//div[@data-testid='item-total-price']
    ${unit_price}=    Get Text    ${unit_price_xpath}
    ${unit_quantity}=    Get Selected List Value    ${unit_quantity_xpath}
    ${total_price}=    Get Text    ${total_price_xpath}
    ${unit_price}=    Evaluate    "${unit_price}".replace(u"\u20AC", '').replace("/", '').replace("pc", '').strip()
    ${total_price}=    Evaluate    "${total_price}".replace(u"\u20AC", '').strip()
    ${expected_total}=    Evaluate    float(${unit_price}) * float(${unit_quantity})
    Should Be Equal As Numbers    ${expected_total}    ${total_price}
    ${total_calculated}=    Evaluate    ${total_calculated} + ${expected_total}
    END
    Set Suite Variable    ${CART_TOTAL_CALCULATED}    ${total_calculated}

The Customer already has a single Product below 45EUR in his cart
    # TODO: need to replace 45 with variable in case the delivery limit fee changes in future
    Posti Shop Page is open
    A single product worth below 45EUR is added to cart
    The Customer opens The Cart

Delivery fee of "${eur}" EUR is applied
    The Customer opens The Cart
    Wait Until Element Is Visible    xpath=//span[@id='cart-totals-shipping-value']
    ${delivery_fee}=    Get Text    xpath=//span[@id='cart-totals-shipping-value']
    ${delivery_fee}=    Evaluate    "${delivery_fee}".replace(u"\u20AC", '').strip()
    Should Be Equal As Numbers    ${delivery_fee}    ${eur}

The customer increases amount of the same product exceeding ${eur} EUR total
    Wait Until Element Is Visible    xpath=//span[@id='cart-totals-subtotal-value']
    ${max_iterations} =  Set Variable  24 

    FOR  ${index}  IN RANGE  1  ${max_iterations}
        ${cart_subtotal}=    Get Text    xpath=//span[@id='cart-totals-subtotal-value']
        ${cart_subtotal}=    Evaluate    "${cart_subtotal}".replace(u"\u20AC", '').strip()
        ${continue_loop}=    Evaluate     ${cart_subtotal} <= ${eur}
        Run Keyword If    ${continue_loop}     Increase number of item in cart by one
        Exit For Loop If    ${continue_loop} == ${False}
    END  

Increase number of item in cart by one
    Click Element    xpath=//button[@data-testid='item-qty-button-increase']
     # TODO: While method below for waiting for cart to reload works in theory, often numbers are still not loaded or spinner does not appear resulting in a failed case and a flaky test run. Need to find a different solution that is not slower.
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'CartTotals__LoaderContainer')]   10
    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'CartTotals__LoaderContainer')]    10

The customer decreases amount of the same product to or below ${eur} EUR total
# TODO: need to optimize and connect with the loop that increases the amount by one
    Wait Until Element Is Visible    xpath=//span[@id='cart-totals-subtotal-value']
    ${max_iterations} =  Set Variable  24 

    FOR  ${index}  IN RANGE  1  ${max_iterations}
        ${cart_subtotal}=    Get Text    xpath=//span[@id='cart-totals-subtotal-value']
        ${cart_subtotal}=    Evaluate    "${cart_subtotal}".replace(u"\u20AC", '').strip()
        ${continue_loop}=    Evaluate     ${cart_subtotal} > ${eur}
        Run Keyword If    ${continue_loop}     Decrease number of item in cart by one
        Exit For Loop If    ${continue_loop} == ${False}
    END  # Terminates the FOR loop

 Decrease number of item in cart by one
 # TODO: need to optimize with the same increase keyword
    Click Element    xpath=//button[@data-testid='item-qty-button-decrease']
     # TODO: While method below for waiting for cart to reload works in theory, often numbers are still not loaded or spinner does not appear resulting in a failed case and a flaky test run. Need to find a different solution that is not slower.
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'CartTotals__LoaderContainer')]   10
    Wait Until Element Is Not Visible    xpath=//div[contains(@class, 'CartTotals__LoaderContainer')]    10