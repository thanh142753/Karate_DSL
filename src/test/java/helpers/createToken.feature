Feature: Create token

    Scenario: Conduit token
        Given url 'https://conduit-api.bondaracademy.com/api/users/login'
        And request {"user":{"email":"thanh142@gmail.com","password":"123456"}}
        When method post
        Then status 200
        * def conduitToken = response.user.token