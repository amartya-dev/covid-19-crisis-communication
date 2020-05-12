# covid-19-crisis-communication
A ChatBot for essential communication and relief during the Covid-19 Crisis

# ToDo
- [ ] Add a server application in Django for processing all the necessary tasks
- [ ] Machine learning models for Covid-19 risk analysis, symptom based probability prediction of being infected by the disease
- [ ] A flutter applicatino to use IBM -Watson ChatBot in order to provide all the requried services

# Features
## Primary
- [ ] Covid-19 risk analysis (i.e. identifying about how much a person is at risk of being infected by the Covid-19 virus based upon certain features which will be decided)
- [ ] Checkup request
- [ ] Request for permission to travel
- [ ] Updates on the number of cases, the area being red zone etc
- [ ] Request for delivery of essential items for senior citizens
- [ ] General FAQ about COVID -19
## Secondary
- [ ] USSD based menu for offline information (possibly IVR)
- [ ] Speech to text for automated detection of request from the recorded calls.

# API

- Endpoint /api-token-auth/
    - Method: POST
    - Request Body:
    ```json
    {
        "username": "<username>",
        "password": "<password>"
    }
    ```
    - Response
    ```json
    {
        "token": "<access_token>"
    }
    ```

- Endpoint: /api/users/
    - Method: POST
    - Headers:
    ```json
    {
        "Authorization": "TOKEN <token>"
    }
    ```
    - Request Body
    ```json
    {
        "user": {
            "username": "<username>",
            "first_name": "<first_name>",
            "last_name": "<last_name>",
            "email": "<your_email>",
            "password": "<password_string>"
        },
        "address": {
            "street_address": "ABD",
            "locality": "DEF",
            "city": "Delhi",
            "pin_code": 123123
        },
        "profile_type": "authorities"
    }
    ```

- Endpoint: /api/create_session/

    - Headers

    ```json
    {
        "Authorization": "TOKEN <token>"
    }
    ``` 
    - Response
    ```json
    {
        "session_id": "<session_id>"
    }
    ```

- Endpoint: /api/chat/
    - Heaaders
    ```json
    {
        "Authorization": "TOKEN <token>"
    }
    ```
    - Request Body
    ```json
    {
        "session_id": "<session_id>",
        "message": "<message_you_want_to_send>"
    }
    ```
    - Response
    ```json
    {
        "response": "<response_from_the_bot>"
    }
    ```
