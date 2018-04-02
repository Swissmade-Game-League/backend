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
		"password": "this_is_my_sick_password",
		"password_confirmation": "this_is_my_sick_password",
		"mail": "email@example.com",
		"birthdate": "1993-01-19",
		"gender": "male",
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
  "mail": "email@example.com",
  "birthdate": "1993-01-19",
  "created_at": "2018-03-17T15:46:35.000Z",
  "updated_at": "2018-03-17T15:46:35.000Z",
  "gender_id": 1,
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
  "mail": "email@example.com",
  "token": "09150c847bcc22765cfc047c",
  "birthdate": "1993-01-19",
  "gender_id": 1,
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
    "mail": "email@example.com",
    "birthdate": "1993-01-19",
    "gender_id": 1,
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
  "mail": "email@example.com",
  "birthdate": "1993-01-19",
  "gender_id": 1,
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
    "mail": "email@example.com",
    "password": "this_is_my_new_sick_password",
    "password_confirmation": "this_is_my_new_sick_password",
    "birthdate": "1993-01-19",
    "gender": "male",
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
  "birthdate": "1993-01-19",
  "gender_id": 1,
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
    "name": "male",
    "created_at": "2018-03-19T10:24:19.906Z",
    "updated_at": "2018-03-19T10:24:19.906Z"
  },
  {
    "id": 2,
    "name": "female",
    "created_at": "2018-03-19T10:24:19.924Z",
    "updated_at": "2018-03-19T10:24:19.924Z"
  },
  {
    "id": 3,
    "name": "other",
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
  "name": "female",
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
  "name": "female",
  "created_at": "2018-03-19T10:24:19.924Z",
  "updated_at": "2018-03-19T10:24:19.924Z"
}
```
