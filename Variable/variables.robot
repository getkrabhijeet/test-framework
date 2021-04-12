*** Settings ***
Documentation  Resource file
*** Variables ***
${AUTH_ID}      MAMWU1M2FKMZCXMWUZOG
${AUTH_TOKEN}   YjNlZTkzYTMxODE2MTcwNDk4OGRlOWFmMjczMGIy

${BASE_URL}    https://api.plivo.com/v1/Account/${AUTH_ID}
${TERMINATING_USER}     17033132729
${MESSAGE_UUID}     None
${NUMBER_URL}   Number
${MESSAGE_URL}  ${BASE_URL}/Message
${PRICING_URL}  ${BASE_URL}/Pricing
${MESSAGE_UID}  ${MESSAGE_URL}/${MESSAGE_UUID}
${COUNTRY_ISO}  country_iso=US

