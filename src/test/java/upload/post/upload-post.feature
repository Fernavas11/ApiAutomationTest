Feature: upload document

  Background:
    * url 'http://localhost:5002/api'
    * def credentials = 'admin:admin'
    * def Base64 = Java.type('java.util.Base64')
    * def encodedCredentials = Base64.getEncoder().encodeToString(credentials.getBytes())
    * def token = 'Bearer ' + encodedCredentials
    * configure charset = null

  Scenario:
    Given header Authorization = token
    And multipart file file = { read: 'img.png', filename: 'img.png' }
    And multipart field name = 'QA BOX LETS TEST'
    And path 'upload'
    When method post
    Then status 201