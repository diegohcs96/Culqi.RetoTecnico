Feature: Create Token

  Background:
    * url 'https://restful-booker.herokuapp.com'

    Scenario: Create Token
      * def body_credentials =
      """
        {
          "username": "admin",
          "password": "password123"
        }
      """

      Given path '/auth'
      And header Content-Type = 'application/json'
      And request body_credentials
      When method post
      Then status 200
      And match response.token == '#string'
      And match response !contains { reason: 'Bad credentials' }
      * def token = response.token