*** Settings ***
Documentation     This suite contains automated tests that test checkout funcitonality, particularily, Finnish post code validation fulfilling part of the home assignment "Upon checkout (without needing to buy, of course), check that the validation of a Finnish postal code works as expected (5 digits). Any boundary cases are based on information here https://www.spotzi.com/en/data-catalog/categories/postal-codes/finland/ that Finland has a range of valid post codes 00100-99990 - for this reason what in the test case is considered valid or not valid is not purely based on form validation.
Resource          ../resources/common_resources.robot
Resource          ../resources/page_objects/cart_page.robot
Resource          ../resources/page_objects/checkout_page.robot
Test Setup        The Customer has added stamps to the cart and proceeds to checkout
Test Template     Valid Post Code Should Pass
Test Teardown     Close Browser

*** Settings ***


*** Test Cases ***                postcode         
Valid Lower Boundary              00100         
Valid Upper Boundary              99990   
Valid Mid Range                   50000          
Valid Near Lower Boundary         00101       
Valid Near Upper Boundary         99989    
