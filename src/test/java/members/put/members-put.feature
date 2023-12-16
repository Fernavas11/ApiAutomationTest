Feature: Put members tests

  Background:
    * url 'http://localhost:5002/api'
    * def credentials = 'admin:admin'
    * def Base64 = Java.type('java.util.Base64')
    * def encodedCredentials = Base64.getEncoder().encodeToString(credentials.getBytes())
    * configure charset = null
    * def token = 'Bearer ' + encodedCredentials
    * def getId = call read('../post/members-post.feature@create')
    * def ID = getId.id


  Scenario: PUT details of members

    Given header Authorization = token
    And header Content-Type = 'application/json'
    And request { "name": "James", "gender": "female" }
    And path 'members/' + ID
    When method put
    Then status 200
    And match $.msg == 'Member with id '+ ID +' is updated successfully'

  Scenario: PUT Bad Request members

    Given header Authorization = token
    And header Content-Type = 'application/json'
    And request { "user" : "James", "gender": "female" }
    And path 'members/' + ID
    When method put
    Then status 400

  Scenario: PUT Unauthorized response

    And header Content-Type = 'application/json'
    And request { "user" : "James", "gender": "female" }
    And path 'members/' + ID
    When method put
    Then status 401
    And match $.error == 'unauthorized'

