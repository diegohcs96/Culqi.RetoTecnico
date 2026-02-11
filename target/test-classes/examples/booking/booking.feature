Feature: Booking

  Background:
    * url 'https://restful-booker.herokuapp.com'
    * def auth = callonce read('../auth/auth.feature')
    * def token = auth.token
    * print 'Token generado:', token

    # Obtener Booking IDs
    Given path '/booking'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match each response[*].bookingid == '#number'
    * def bookingIds = response

    # Tomar el primer Booking ID
    * def bookingId = bookingIds[0].bookingid
    * print 'Booking ID seleccionado:', bookingId


  Scenario: Get Booking
    Given path '/booking', bookingId
    And header Accept = 'application/json'
    When method get
    Then status 200

    * print `Response bookingId ${bookingId}:`, response

    And match response.firstname != ''
    And match response.lastname != ''

  Scenario: Update Booking
    * def body_update_booking =
      """
        {
          "firstname": "Diego",
          "lastname": "Campos",
          "totalprice": 9999,
          "depositpaid": false,
          "bookingdates": {
            "checkin": "2026-09-26",
            "checkout": "2027-09-26"
          },
          "additionalneeds" : "Pass Culqi Test"
        }
      """

    Given path '/booking', bookingId
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = 'token=' + token
    And request body_update_booking
    When method put
    Then status 200

    * print `Response actualizado bookingId ${bookingId}:`, response

    And match response.firstname == 'Diego'
    And match response.lastname == 'Campos'
    And match response.totalprice == 9999
    And match response.depositpaid == false
    And match response.bookingdates.checkin == '2026-09-26'
    And match response.bookingdates.checkout == '2027-09-26'
    And match response.additionalneeds == 'Pass Culqi Test'
