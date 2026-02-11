Feature: Create Token

  Background:
    * url 'https://restful-booker.herokuapp.com'

    Scenario: Create Token
      * def body_credentials =
      """
        {
          "username" : "admin",
          "password": "password123"
        }
      """

      Given path 'auth'
      When method post
      Then status 200