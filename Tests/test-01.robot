*** Settings ***
Resource    ../Resources/common.robot
Suite Setup     Initialize Session With Plivo
Suite Teardown  Delete All Sessions

*** Test Cases ***
Check if Number fetched from account is Valid
    [Documentation]  Test-1
    Log Variables
    Verify Valid Number

Verify Enough credit is present in account to send a message
    [Documentation]  Test-2
    Verify Credits

Sending Message to another user
    [Documentation]  Test-3
    Set Suite Variable    ${text}    TestMessage1
    Send Message    ${TERMINATING_USER}    ${text}

Validate charges incurred are as per Outbound rates
    [Documentation]  Test-4
    Fetch Charges Incurred for Last Message
    Should Be Equal As Strings      ${AMOUNT_DEDUCTED}  ${OUTBOUND_RATE}

Validate balance deducted from account and deduction is as per Outbound rates for single message
    [Documentation]  Test-5
    ${balance}  Convert To Number   ${CREDITS}
    Sleep   10s     Waiting for account updation
    Fetch Credits
    ${balance_post_message}  Convert To Number   ${CREDITS}
    ${deduction}   Evaluate   ${balance}-${balance_post_message}
    Should be equal as numbers    ${deduction}   ${OUTBOUND_RATE}


