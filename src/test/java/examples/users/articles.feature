Feature: Articles

    Background: Base URL
        Given url 'https://conduit-api.bondaracademy.com/api/'
        # Get token
        Given path 'users/login'
        And request {"user":{"email":"thanh142@gmail.com","password":"123456"}}
        When method post
        Then status 200
        * def token = response.user.token


    @CreateAricles-DeleteArticle-Verify
    Scenario: 
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
