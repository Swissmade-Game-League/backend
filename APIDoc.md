## Home

**Endpoint**: GET - https://api_endpoint.tld/

**Description**: Get app short infos

#### Response
```
{
  "name": "Swiss Game League",
  "environment": "preproduction",
  "version": {
    "number": "1.0",
    "build_hash": "6be204a6fc0befa8be49efa8618f016cc8a82b37"
  },
  "tagline": "Grinding the ladder, You Know"
}
```

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
		"mail": "clement.hampai@cypressxt.net",
		"birthdate": "1993-01-19"
	}
}
```

#### Response
```
{
  "id": 1,
  "firstname": "clément",
  "lastname": "hampaï",
  "mail": "clement.hampai@cypressxt.net",
  "birthdate": "1993-01-19",
  "created_at": "2018-03-17T15:46:35.000Z",
  "updated_at": "2018-03-17T15:46:35.000Z"
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
    "mail": "clement.hampai@cypressxt.net",
    "birthdate": "1993-01-19",
    "created_at": "2018-03-16T07:11:30.480Z",
    "updated_at": "2018-03-16T07:11:30.480Z"
  }
]
```

## Get user

**Endpoint**: GET - https://api_endpoint.tld/users/8

**Description**: Get a user by id


#### Response
```
{
  "id": 8,
  "firstname": "clément",
  "lastname": "hampaï",
  "mail": "clement.hampai@cypressxt.net",
  "birthdate": "1993-01-19",
  "created_at": "2018-03-16T07:11:30.480Z",
  "updated_at": "2018-03-16T07:11:30.480Z"
}
```

## Update user

**Endpoint**: PATCH - https://api_endpoint.tld/users/8

**Description**: Update user's properties by user id

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
		"mail": "clement.hampai2@cypressxt.net",
		"birthdate": "1993-01-19"
	}
}
```

#### Response
```
{
  "mail": "clement.hampai2@cypressxt.net",
  "id": 8,
  "firstname": "clément",
  "lastname": "hampaï",
  "birthdate": "1993-01-19",
  "created_at": "2018-03-16T07:11:30.480Z",
  "updated_at": "2018-03-16T07:11:30.939Z"
}
```

## Delete user

**Endpoint**: DELETE - https://api_endpoint.tld/users/8

**Description**: Delete a user by id


#### Body
```
{
  "info": "User deleted",
  "status": 200
}
```
