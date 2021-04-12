*** Settings ***
Library     RequestsLibrary
Library     json
Library     Collections
#Library     HttpLibrary.HTTP3
Resource    ../Variable/variables.robot
Resource    keywords.robot
Library     String
Library     ../CustomLibrary/base64Encode.py
Library     ../CustomLibrary/Validate_Credits.py
Library     ../CustomLibrary/Validate_Number.py
Library     ../CustomLibrary/Correct_Json.py
Library     BuiltIn
Library     JSONLibrary