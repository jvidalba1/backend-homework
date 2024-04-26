# README

Backend Homework with Movies topic

- Ruby version: 3.1.2
- Rails version: 7.1.3.2

## Installation

- Clone this repository in your local machine
- Go to the folder cloned
- Install dependencies gems
- Setup database
- Create seed data

```bash
git clone git@github.com:jvidalba1/backend-homework.git
cd backend-homework
bundle install
rails db:create
rails db:migrate
rails db:seed
```

## Usage

- Run a local server in the console in the project directory:

```bash
rails server
```

You can use Postman for hitting the API or your requester of preference:

### Registrations 

First, create an user:

POST "localhost:3000/registrations"
example params:
```json
{
    "user": {
        "first_name": "First Name",
        "last_name": "Last Name",
        "email": "first_last@sample.com",
        "password": "TestingFirst!",
        "birthday": "1991-04-02"
    }
}
```

- first_name, last_name, email and password are mandatory fields
- password have to contain at least 10 characters, one lowercase letter, one
uppercase letter and one of the following characters: !, @, #, ? or ].

### Sessions

Once you have been registered, create a session to retrieve a token

POST "localhost:3000/sessions"
example params:
```json
{
    "email": "first_last@sample.com",
    "password": "TestingFirst!"
}
```
- you will receive a token, which should be used to retrieve api resources (movies),
this token expires after 20 minutes, then you will have to create another token session.

### Resources (movies)

In all the following requests, you have to provide a header `Authorization` with the token 
received in sessions endpoint, in order to be authorized to execute actions.

```json
'Authorization: Bearer <token>'
```
Replace <token> with token provided in sessions endpoint.

#### Read

- Read movies with public access
> Note: In this endpoint you can provide, how many resources you can receive
per page (per_page) and which page you have to retrieve (page), if theses params are not
sent, default values will be set. page: 1, per_page: 3

GET "localhost:3000/movies"
```json
{
    "page": 1,
    "per_page": 2,
    "accessibility": "public"
}
```

- Read own movies only

GET "localhost:3000/movies"
```json
{
    "accessibility": "private"
}
```

> Note: If accessibility filter is not provided, endpoint will return public resources
> by default.

#### Create

- Create movies with public or private access

POST "localhost:3000/movies"
example params
```json
{
    "movie": {
        "name": "Testing private title movie",
        "producer": "Testing private producer name",
        "accessibility": "self",
        "released_date": "2000-04-02"
    }
}
```
- `accessibility` could be `self` for private access and `for_all` for public access
- name and accessibility are mandatory fields

#### Update

- Update movies info, you can update one or more attributes

PUT "localhost:3000/movies/<id_movie>"
```json
{
    "movie": {
        "name": "New title movie",
        "producer": "New producer name",
        "accessibility": "for_all"
    }
}
```


### Random number 

Get a random number, you can specify min and max values,
or just get a full random number

You don't any token here.

GET "localhost:3000/random"
```json
{
    "min": 5,
    "max": 10
}
```

GET "localhost:3000/random"
```json
{
}
```
