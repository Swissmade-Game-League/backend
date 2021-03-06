# Home

**Endpoint**: GET - https://api_endpoint.tld/

**Description**: Get app short infos

#### Response
```
{
  "name": "Swiss Made Game League",
  "environment": "development",
  "repo": "https://github.com/Swissmade-Game-League/backend",
  "version": {
    "number": "1.0",
    "build_hash": "3b68375a4bab411f021b88ec07d8bc310b132d9e"
  },
  "tagline": "Grinding the ladder, you know"
}
```

# Users

## Create user

**Endpoint**: POST - https://api_endpoint.tld/users

**Description**: Create a new user

#### Header
```
{
	Content-Type: application/json; charset=utf-8
}
```


#### Body
```
{
	"user": {
		"firstname": "Clément",
		"lastname": "Hampaï",
		"nickname": "CypressXt",  
		"password": "this_is_my_sick_password",
		"password_confirmation": "this_is_my_sick_password",
		"mail": "email@example.com",
		"birthdate": "1993-01-19",
		"gender_id": 1,
		"team_name": "V12",
		"favorite_game": "Guild Wars",
		"dev": false,
		"address": {
			"number": 4,
			"street": "rue du tryhard",
			"locality": {
				"name": "Genève",
				"postal_code": "1202"
			},
			"state": {
				"name": "Genève"
			},
			"country": {
				"name": "Switzerland"
			}
		}
	}
}
```

#### Response
```
{
  "id": 1,
  "firstname": "clément",
  "lastname": "hampaï",
  "nickname": "CypressXt",
  "mail": "email@example.com",
  "birthdate": "1993-01-19",
  "created_at": "2018-03-17T15:46:35.000Z",
  "updated_at": "2018-03-17T15:46:35.000Z",
  "gender_id": 1,
  "team_name": "V12",
  "favorite_game": "Guild Wars",
  "dev": false,
  "address_id": 1
}
```

## authenticate user

**Endpoint**: POST - https://api_endpoint.tld/authenticate

**Description**: Authenticate a user by mail and password

#### Header
```
{
	Content-Type: application/json; charset=utf-8
}
```


#### Body
```
{
  "user": {
    "mail": "email@example.com",
    "password": "this_is_my_sick_password"
  }
}
```

#### Response
```
{
  "id": 10,
  "firstname": "clément",
  "lastname": "hampaï",
  "nickname": "CypressXt",
  "mail": "email@example.com",
  "token": "09150c847bcc22765cfc047c",
  "birthdate": "1993-01-19",
  "gender_id": 1,
  "team_name": "V12",
  "favorite_game": "Guild Wars",
  "dev": false,
  "address_id": 1,
  "created_at": "2018-03-19T07:10:19.161Z",
  "updated_at": "2018-03-19T07:10:19.161Z"
}
```

## Get users

**Endpoint**: GET - https://api_endpoint.tld/users/

**Description**: Get all users


#### Response
```
[
  {
    "id": 8,
    "firstname": "clément",
    "lastname": "hampaï",
    "nickname": "CypressXt",
    "mail": "email@example.com",
    "birthdate": "1993-01-19",
    "gender_id": 1,
    "team_name": "V12",
    "favorite_game": "Guild Wars",
    "dev": false,
    "address_id": 1,
    "created_at": "2018-03-16T07:11:30.480Z",
    "updated_at": "2018-03-16T07:11:30.480Z"
  }
]
```

## Get user

**Endpoint**: GET - https://api_endpoint.tld/users/user_id

**Description**: Get a user by id

**Parameters**: `user_id`: needed user's id


#### Response
```
{
  "id": 8,
  "firstname": "clément",
  "lastname": "hampaï",
  "nickname": "CypressXt",
  "mail": "email@example.com",
  "birthdate": "1993-01-19",
  "gender_id": 1,
  "team_name": "V12",
  "favorite_game": "Guild Wars",
  "dev": false,
  "address_id": 1,
  "created_at": "2018-03-16T07:11:30.480Z",
  "updated_at": "2018-03-16T07:11:30.480Z"
}
```

## Update user

**Endpoint**: PATCH - https://api_endpoint.tld/users/user_id

**Description**: Update user's properties by user id

**Parameters**: `user_id`: needed user's id


#### Header
```
{
	Content-Type: application/json; charset=utf-8
}
```


#### Body
```
{
  "user": {
    "firstname": "Clément",
    "lastname": "Hampaï",
    "nickname": "CypressXt",  
    "mail": "email@example.com",
    "password": "this_is_my_new_sick_password",
    "password_confirmation": "this_is_my_new_sick_password",
    "birthdate": "1993-01-19",
    "gender": "male",
    "team_name": "V12",
    "favorite_game": "Guild Wars",
    "dev": false,
    "token": "5cc5e4224c5d0c006eda75fc"
  }
}
```

#### Response
```
{
  "mail": "email2@example.com",
  "id": 8,
  "firstname": "clément",
  "lastname": "hampaï",
  "nickname": "CypressXt",
  "birthdate": "1993-01-19",
  "gender_id": 1,
  "team_name": "V12",
  "favorite_game": "Guild Wars",
  "dev": false,
  "address_id": 1,
  "created_at": "2018-03-16T07:11:30.480Z",
  "updated_at": "2018-03-16T07:11:30.939Z"
}
```

## Delete user

**Endpoint**: DELETE - https://api_endpoint.tld/users/user_id

**Description**: Delete a user by id

**Parameters**: `user_id`: needed user's id



#### Body
```
{
  "user": {
    "token": "09150c847bcc22765cfc047c"
  }
}
```

#### Response
```
{
  "info": "User deleted",
  "status": 200
}
```

# Genders

## Get genders

**Endpoint**: GET - https://api_endpoint.tld/genders/

**Description**: Get all genders


#### Response
```
[
  {
    "id": 1,
    "name": "Male",
    "created_at": "2018-03-19T10:24:19.906Z",
    "updated_at": "2018-03-19T10:24:19.906Z"
  },
  {
    "id": 2,
    "name": "Female",
    "created_at": "2018-03-19T10:24:19.924Z",
    "updated_at": "2018-03-19T10:24:19.924Z"
  },
  {
    "id": 3,
    "name": "Other",
    "created_at": "2018-03-19T10:24:19.939Z",
    "updated_at": "2018-03-19T10:24:19.939Z"
  }
]
```

## Get gender

**Endpoint**: GET - https://api_endpoint.tld/genders/gender_id

**Description**: Get a gender by id

**Parameters**: `gender_id`: needed gender's id


#### Response
```
{
  "id": 2,
  "name": "Female",
  "created_at": "2018-03-19T10:24:19.924Z",
  "updated_at": "2018-03-19T10:24:19.924Z"
}
```

## Get gender by name

**Endpoint**: GET - https://api_endpoint.tld/genders/by_name/gender_name

**Description**: Get a gender by name

**Parameters**: `gender_name`: needed gender's name


#### Response
```
{
  "id": 2,
  "name": "Female",
  "created_at": "2018-03-19T10:24:19.924Z",
  "updated_at": "2018-03-19T10:24:19.924Z"
}
```

# Payments

## Create a cash payment

**Endpoint**: POST - https://api_endpoint.tld/payments

**Description**: Create a new cash payment

#### Header
```
{
	Content-Type: application/json; charset=utf-8
}
```


#### Body
```
{
  "payment": {
    "user_id": "13",
    "user_token": "1850bd1654a7291292873946",
    "amount": "12"
  }
}
```

#### Response
```
{
  "message": "Thanks, your payment is waiting for validation. This process could take some days.",
  "payment": {
    "id": 9,
    "amount": 12.0,
    "paid": false,
    "token": "ed7f8d69756af97ef99ce29bc468b7fde200dfb2dcb114eb",
    "user_id": 13,
    "created_at": "2018-04-03T22:15:30.900Z",
    "updated_at": "2018-04-03T22:15:30.923Z"
  },
  "status": 200
}
```


## Create a credit card payment

**Endpoint**: POST - https://api_endpoint.tld/payments

**Description**: Create a new cash payment

#### Header
```
{
	Content-Type: application/json; charset=utf-8
}
```


#### Body
```
{
  "payment": {
    "user_id": "13",
    "user_token": "1850bd1654a7291292873946",
    "amount": "12",
    "stripeToken": "tok_1CCxaRLZISEaaGqL0Vgy12AF"
  }
}
```

#### Response
```
{
  "message": "You're payment has been validated",
  "payment": {
    "id": 18,
    "amount": 12.0,
    "paid": true,
    "token": "7bc3b8d7c59f7a9888b209f796e6e3e09ffe17977145e0e7",
    "user_id": 13,
    "created_at": "2018-04-03T22:37:04.188Z",
    "updated_at": "2018-04-03T22:37:08.125Z"
  },
  "status": 200
}
```

# Addresses

## Get valid address from query

**Endpoint**: POST - https://api_endpoint.tld/validate-addr

**Description**: Make a short address query and get a valid address from Google Maps

#### Header
```
{
	Content-Type: application/json; charset=utf-8
}
```


#### Body
```
{
  "query": "Rue liothard 4"
}
```

#### Response
```
{
  "lat": 46.2094824,
  "lng": 6.134610899999999,
  "formatted_address": "Rue Liotard 4, 1202 Genève, Switzerland",
  "street_number": "4",
  "street_name": "Rue Liotard",
  "city": "Genève",
  "department": "Genève",
  "department_code": "Genève",
  "state": "Genève",
  "state_code": "GE",
  "country": "Switzerland",
  "country_code": "CH",
  "zip_code": "1202",
  "street": "4 Rue Liotard"
}
```

# Ladder

## Get the ladder

**Endpoint**: GET - https://api_endpoint.tld/ladder/

**Description**: Get all competitive players ranked by ladder points

**Still in development, ladder points are not available yet**

#### Response
```
[
  {
    "id": 1,
    "firstname": "clément",
    "lastname": "hampaï",
    "mail": "clement.hampai@cypressxt.net",
    "birthdate": "1993-01-19",
    "created_at": "2018-04-05T22:42:08.741Z",
    "updated_at": "2018-04-24T05:53:17.953Z",
    "nickname": "CypressXt",
    "team_name": "V_12",
    "dev": false,
    "favorite_game": null,
    "address": {
      "locality": {
        "id": 5,
        "name": "Carouge",
        "postal_code": 1227,
        "created_at": "2018-04-05T22:42:07.705Z",
        "updated_at": "2018-04-05T22:42:07.705Z",
        "state_id": 1,
        "state": {
          "id": 1,
          "name": "Genève",
          "created_at": "2018-04-02T17:48:06.740Z",
          "updated_at": "2018-04-02T18:25:57.932Z",
          "country_id": 2,
          "country": {
            "id": 2,
            "name": "Switzerland",
            "created_at": "2018-04-02T18:25:57.918Z",
            "updated_at": "2018-04-02T18:25:57.918Z"
          }
        }
      }
    },
    "gender": {
      "id": 1,
      "name": "male",
      "created_at": "2018-04-02T17:13:38.684Z",
      "updated_at": "2018-04-02T17:13:38.684Z"
    }
  }
]
```
