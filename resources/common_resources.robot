*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary
Library           String
Library           Collections

*** Variables ***
${BROWSER}        Chrome     
${MAX_AMOUNT_DELIVERY_FEE}     45
${DELIVERY_FEE}     5

*** Keywords ***
#TODO: Tests need clearer error handling