# TEST SHORTENER URL
---------------------------------------------------------------------

## Table of Contents
* [Specs](#specs)
* [With Docker](#with-docker)
    * [Prerequisites with Docker](#prerequisites-with-docker)
    * [Install with Docker](#install-with-docker)
    * [Set up database with Docker](#set-up-database-with-docker)
        * [Create db with docker](#create-db-with-docker)
        * [Init db structure with docker](#init-db-structure-with-docker)
        * [Populate db with seeds](#populate-db-with-docker)
        * [Reset database](#db-reset)
    * [Run the app with Docker](#run-the-app-with-docker)
    * [Remove created containers & images](#remove-created-containers--images)
* [Without Docker / classic](#without-docker--classic)
    * [Requirements](#requirements)
    * [Setup](#setup)
    * [Dependencies](#dependencies)
    * [Database creation](#database-creation)
    * [Run](#run)
* [API](#api)
    * [Authentication](#authentication)
    * [Creation an URL shortener](#creation-an-url-shortener)
    * [Redirection to original URL](#redirection-to-original-url)
* [Test](#test)
---------------------------------------------------------------------

## Specs

### Subject statement

Create an API to create URL shortener

## Architecture
- Swagger for the document and test API
- Rubocop for the code formatter
- Rspec for the test

### How to create an URL shortener

- For each record of Original URL create, We will get the ID and convert it to Base62 [0-9 , a-z , A-Z] by using `gem base62-rb`
- The ID in base62 is the ID for the URL shortener. It's also indexed in the URLShortLink table for the research
- For the performance and database availability, we could also use redis for cache `key: base62` and `value: original_url`

-----------------------------------------------------

## With Docker

### Prerequisites with Docker

- You must have a running version of [docker](https://www.docker.com/)

To install it see [official doc](https://docs.docker.com/desktop/#download-and-install)

Everything else is set into `docker-compose.yml file`

### Install with Docker

Build the app
```shell script
docker-compose build
```

Check docker images
```shell script
docker images
# You should see an image `development_url_shortener` recently created with a tag `latest`
```

### Set up database with Docker

/!\ Already done with docker-entrypoint.sh /!\

See `docker-entrypoint.sh` and `Dockerfile`

BTW, if needed, here is how to launch db operation into running container

#### Create DB with Docker

Create DB
```shell script
docker-compose run url_shortener rake db:create
```

#### Init DB structure with Docker

Run the migrations to create db structure
```shell script
docker-compose run url_shortener rake db:migrate
```

#### Populate db with Docker

To populate the database with random data you could run
```shell script
docker-compose run url_shortener rake db:seed
```

#### DB reset with Docker

If needed, reset and reinstall db with :
```shell script
docker-compose run url_shortener rake db:reset
```

### Run the app with Docker

Run the app
```shell script
docker-compose up
```

### Remove created containers & images

List all containers
```
docker ps -a
```

Note the CONTAINER_ID corresponding to the app

Remove it
```
docker rm {CONTAINER_ID}
```

List all images
```
docker images
```

Note the IMAGE_ID corresponding to the app

Remove it
```
docker image rm {IMAGE_ID}
```

-----------------------------------------------------
## Without Docker / classic
### Requirements
* ruby 3.2.2
* rails 7.0.4
* psql (PostgreSQL) 11.0

### Setup
#### Dependencies

```bash  
bundle install  
```  
#### Database creation

```bash  
bundle exec rake db:create  
bundle exec rake db:migrate
bundle exec rake db:seed
```

#### Run

```bash  
rails s -p 4000
```  

Test the API at http://localhost:4000/api-docs/index.html with Swagger UI

For the POST /api/shorten you have to get the authorization token and login to use this endpoint

-----------------------------------------------------

## API
There are three endpoints:

### Authentication
`POST /authenticate`
Authentication and retrieve the jwt token. User "example@mail.com" is created in seed

**payload**

```json
{
  "email": "example@mail.com",
  "password": "123123123"
}
```

### Creation an URL shortener 
`POST /api/shorten`
Create a URL shortener from an url for an authorized user

**payload**

```json
{
  "original_url": "string"
}
```

### Redirection to original URL 
`GET /{shorten_id}`

Put the URL shortener `http://localhost:4000/{shorten_id}` to browser for the direction

-----------------------------------------------------

## Test
run rspec test for `models`, `requests`
```bash  
rspec
```  