Feature: Articles

    Background: Base URL
        Given url 'https://conduit-api.bondaracademy.com/api/'
        * def tokenResponse = call read('classpath:helpers/createToken.feature')
        * def token = tokenResponse.conduitToken
    @createAricles-deleteArticle
    Scenario: get Token
        # Create article
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article":{"title":"test-thanh","description":"test articles","body":"test","tagList":["test articles"]}}
        When method post
        Then status 201
        And match response.article.title == 'test-thanh'
        * def slug = response.article.slug
        * def authorName = response.article.author.username
        # Delete article
        Given header Authorization = 'Token ' + token
        Given path 'articles/' + slug
        When method delete
        Then status 204
        # Verify article is deleted
        Given header Authorization = 'Token ' + token
        Given params { author: '#(authorName)', limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        Then match response.articles[*].title !contains 'test-thanh'    
