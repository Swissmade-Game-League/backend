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
		"birthdate": "1993-01-19",
		"gender": "male"
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
  "updated_at": "2018-03-17T15:46:35.000Z",
  "gender_id": 1
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
    "mail": "clement.hampai@cypressxt.net",
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
  "mail": "clement.hampai@cypressxt.net",
  "token": "09150c847bcc22765cfc047c",
  "birthdate": "1993-01-19",
  "gender_id": 1,
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
    "mail": "clement.hampai@cypressxt.net",
    "birthdate": "1993-01-19",
    "gender_id": 1,
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
  "mail": "clement.hampai@cypressxt.net",
  "birthdate": "1993-01-19",
  "gender_id": 1,
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
    "mail": "clement.hampai@cypressxt.net",
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
  "mail": "clement.hampai2@cypressxt.net",
  "id": 8,
  "firstname": "clément",
  "lastname": "hampaï",
  "birthdate": "1993-01-19",
  "gender_id": 1,
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
