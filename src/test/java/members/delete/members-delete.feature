Feature: Delete members tests

  Background:
    * url 'http://localhost:5002/api'
    * def credentials = 'admin:admin'
    * def Base64 = Java.type('java.util.Base64')
    * def encodedCredentials = Base64.getEncoder().encodeToString(credentials.getBytes())
    * configure charset = null
    * def token = 'Bearer ' + encodedCredentials
    * def getId = call read('../post/members-post.feature@create')
    * def ID = getId.id


  Scenario: Delete details of members

    Given header Authorization = token
    And header Content-Type = 'application/json'
    And path 'members/' + ID
    When method delete
    Then status 200

    Scenario: Member with id X doesn't exist response
      Given header Authorization = token
      And header Content-Type = 'application/json'
      And path 'members/' + 0298392
      When method delete
      Then status 404

  Scenario: Delete Unauthorized response

    And header Content-Type = 'application/json'
    And request { "user" : "James", "gender": "female" }
    And path 'members/' + ID
    When method Delete
    Then status 401
    And match $.error == 'unauthorized'