# TEST SHORTENER URL

Create an API to create URL shortener

## Requirements
* ruby 3.2.2
* rails 7.0.4
* psql (PostgreSQL) 11.0

## Setup
### Dependencies

```bash  
bundle install  
```  
### Database creation

```bash  
bundle exec rake db:create  
bundle exec rake db:migrate
bundle exec rake db:seed
```  

### Test
run rspec test for `models`, `requests`
```bash  
rspec
```  

### Run

```bash  
rails s -p 4000
```  

Test the API at http://localhost:4000/api-docs/index.html with Swagger UI

For the POST /api/shorten you have to get the authorization token and login to use this endpoint

## API
There are two endpoints:

### `POST /authenticate`
Authentication and retrieve the jwt token. User "example@mail.com" is created in seed

**payload**

```json
{
  "email": "example@mail.com",
  "password": "123123123"
}
```

### `POST /api/shorten`
Create a URL shortener from an url for an authorized user

**payload**

```json
{
  "original_url": "string"
}
```

### `GET /{shorten_id}`

Put the URL shortener `http://localhost:4000/{shorten_id}` to browser for the direction

## Architecture
- Swagger for the document and test API
- Rubocop for the code formatter
- Rspec for the test

### How to create an URL shortener

- For each record of Original URL create, We will get the ID and convert it to Base62 [0-9 , a-z , A-Z] by using `gem base62-rb`
- The ID in base62 is the ID for the URL shortener. It's also indexed in the URLShortLink table for the research
- For the performance and database availability, we could also use redis for cache `key: base62` and `value: original_url`