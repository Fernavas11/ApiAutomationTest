Feature: Post members tests

  Background:
    * url 'http://localhost:5002/api'
    * def credentials = 'admin:admin'
    * def Base64 = Java.type('java.util.Base64')
    * def encodedCredentials = Base64.getEncoder().encodeToString(credentials.getBytes())
    * def token = 'Bearer ' + encodedCredentials
    * configure charset = null

    @create
  Scenario: POST details of members
    Given header Authorization = token
    And header Content-Type = 'application/json'
    And request { "name": "test", "gender": "male" }
    And path 'members'
    When method post
    Then status 201
    * match $.id == '#number'
    * def id = $.id

  Scenario: POST Bad Request members
    * configure charset = null
    Given header Authorization = token
    And header Content-Type = 'application/json'
    And request { "name": "test", "gender": "male", "id": "230" }
    And path 'members'
    When method post
    Then status 400

  Scenario: POST Unauthorized response members
    And header Content-Type = 'application/json'
    And request { "name": "test", "gender": "male"}
    And path 'members'
    When method post
    Then status 401

