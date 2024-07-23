Feature: test conduit

    Background: Main URL
        Given url 'https://conduit-api.bondaracademy.com/api/'

    Scenario: Sample
        Given path 'tags'
        When method Get
        Then status 200

    @debug
    Scenario: Get 10 articles from the page
        Given params { author: 'Thanh142', limit: 10, offset: 0 }
        Given path 'articles'
        # Given params { limit: 10, offset: 0 }
        # Given path 'articles'
        When method Get
        Then status 200

        # * print karate.prettyUrl(karate.prevRequest)
        
