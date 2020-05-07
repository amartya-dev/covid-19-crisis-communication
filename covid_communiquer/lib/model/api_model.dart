class UserLogin {
  String username;
  String password;

  UserLogin({this.username, this.password});

  Map <String, dynamic> toDatabaseJson() => {
    "username": this.username,
    "password": this.password
  };
}

class Address {
  String streetAddress;
  String locality;
  String city;
  String state;
  int pinCode;

  Address({
    this.streetAddress,
    this.locality,
    this.city,
    this.state,
    this.pinCode
  });

  Map<String, dynamic> toDatabaseJson() => {
    "street_address": this.streetAddress,
    "locality": this.locality,
    "city": this.city,
    "state": this.state,
    "pin_code": this.pinCode
  };
}

class UserDetails {
  String username;
  String firstName;
  String lastName;
  String email;
  String password;

  UserDetails({
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.password
  });

  Map <String, dynamic> toDatabaseJson() => {
    "username": this.username,
    "first_name": this.firstName,
    "last_name": this.lastName,
    "email": this.email,
    "password": this.password
  };
}

class UserSignup {
  UserDetails user;
  Address address;

  UserSignup({
    this.user,
    this.address
  });

  Map<String, dynamic> toDatabaseJson() => {
    "user": this.user.toDatabaseJson(),
    "address": this.address.toDatabaseJson(),
    "profile_type": "user"
  };
}

class Token{
  String token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['token']
    );
  }
}
