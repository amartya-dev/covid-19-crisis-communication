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

- Endpoint: /users/

- Format

```json
{
    "user": {
        "username": "admin",
        "first_name": "",
        "last_name": "",
        "email": "",
        "password": "pbkdf2_sha256$180000$KBmwpa1k0otJ$XYnAR07X5jk7gDAyN1n0cxzY13lFLQug2NwUnCNB4ng="
    },
    "address": {
        "street_address": "ABD",
        "locality": "DEF",
        "city": "Ghaziabad",
        "pin_code": 201002
    }
    "profile_type": "authorities"
}
```