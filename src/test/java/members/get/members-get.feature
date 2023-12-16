Feature: Get members tests

  Background:
    * url 'http://localhost:5002/api'
    * def credentials = 'admin:admin'
    * def Base64 = Java.type('java.util.Base64')
    * def encodedCredentials = Base64.getEncoder().encodeToString(credentials.getBytes())
    * def token = 'Bearer ' + encodedCredentials

  Scenario: Get details of members

    Given header Authorization = token
    And path 'members'
    And param gender = 'male'
    When method GET
    Then status 200

  Scenario: members not found

    Given header Authorization = token
    And path 'members'
    And param gender = 'malo'
    When method GET
    Then status 404

  Scenario: unAuthorizacion credentials

    Given path 'members'
    And param gender = 'male'
    When method GET
    Then status 401


