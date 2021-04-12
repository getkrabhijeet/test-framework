*** Settings ***
Resource  common.robot

*** Keywords ***
Initialize Session With Plivo
    Create Session With Plivo
    Fetch Number
    Fetch Credits
    Fetch Outbound Message Rate


Create Session With Plivo
    ${auth}=    Convert To Bytes   ${AUTH_ID}:${AUTH_TOKEN}
    ${auth}=    Base64 Encode   ${auth}
#    log to console  ${auth}
    ${headers}=     Catenate    Basic   ${auth}
#    log to console  ${headers}
#    ${headers}=     Catenate   ${headers}   ${auth}
#    log to console  ${headers}
    Set Suite Variable    ${headers}     ${headers}
    ${headers}=     Create Dictionary   Authorization=${headers}
#    log to console  ${headers}
    Create Session  alias=plivo   url=${BASE_URL}   headers=${headers}  verify=true

Fetch Number
    ${resp}=  GET On Session  plivo   /Number/
    ${NUMBER}=   get value from json    ${resp.json()}    $.objects[0].number
    Set Suite Variable    ${NUMBER}     ${NUMBER[0]}
#    log to console  ${NUMBER}

Fetch Credits
    ${resp}=  GET On Session  plivo     /
    ${CREDITS}=   get value from json    ${resp.json()}    $.cash_credits
    Set Suite Variable    ${CREDITS}     ${CREDITS[0]}
    #log to console      ${CREDITS}

    #    log to console  ${resp_plivo.content}
Fetch Outbound Message Rate
    ${resp}=  GET On Session  plivo     /Pricing/   params=${COUNTRY_ISO}
    ${OUTBOUND_RATE}=   get value from json    ${resp.json()}    $.message.outbound.rate
    Set Suite Variable    ${OUTBOUND_RATE}     ${OUTBOUND_RATE[0]}


Get Account Credit
    Log     Doing Another thing...

Verify Deduction As Per Profile
    Log     verifying deduction as per profile

Do GET
    Log     do get request

Do POST
    Log     do post request

Verify Valid Number
    Variable Should Exist   ${NUMBER}
    ${BOOL}=    Validate Number     ${NUMBER}
    Should be equal     ${BOOL}     ${true}
    Log     ${NUMBER}

Verify Credits
    Variable Should Exist   ${CREDITS}
    ${BOOL}=    Validate Credits    ${CREDITS}      ${OUTBOUND_RATE}
    Should be equal     ${BOOL}   ${true}
    Log  ${CREDITS}

Send Message
    [Arguments]     ${term_user}    ${text}
    ${data}=    Create Dictionary   src=${NUMBER}   dst=${term_user}     text=${text}
#    Log to console      ${data}
    ${data}=    Correct Json    ${data}
#    Log to console      ${data}
    ${headers1} =  Create Dictionary  Content-Type=application/json     Authorization=${headers}
#    Log to console      ${headers1}
    ${resp}=  POST On Session  plivo     /Message/   data=${data}   headers=${headers1}
#    Log to console  ${resp.json()}
    Should Be Equal As Strings  ${resp.status_code}     202
    ${MESSAGE_UUID}=    get value from json    ${resp.json()}    $.message_uuid[0]
    Set Suite Variable    ${MESSAGE_UUID}     ${MESSAGE_UUID[0]}
#    log to console      ${MESSAGE_UUID}

Fetch Charges Incurred for Last Message
    ${resp}=  GET On Session  plivo     /Message/${MESSAGE_UUID}
    Should Be Equal As Strings  ${resp.status_code}     200
    ${AMOUNT_DEDUCTED}=   get value from json    ${resp.json()}    $.total_amount
    Set Suite Variable    ${AMOUNT_DEDUCTED}     ${AMOUNT_DEDUCTED[0]}
