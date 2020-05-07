part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}


class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class PinCodeChanged extends RegisterEvent {
  final int pinCode;

  const PinCodeChanged({@required this.pinCode});

  @override
  List<Object> get props => [pinCode];

  @override
  String toString() => 'PinCodeChanged { pinCode: $pinCode }';
}

class Submitted extends RegisterEvent {
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String streetAddress;
  final String locality;
  final String city;
  final String state;
  final int pinCode;

  const Submitted({
    @required this.userName,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
    @required this.streetAddress,
    @required this.locality,
    @required this.city,
    @required this.state,
    @required this.pinCode,
  });

  @override
  List<Object> get props => [userName, firstName, lastName, email, password, streetAddress, locality, city, state, pinCode];

  @override
  String toString() {
    return 'Submitted { username: $userName, first_name: $firstName, last_name: $lastName, $email, password: $password, streetAddress: $streetAddress, locality: $locality, city: $city, state: $state, pinCode: $pinCode }';
  }
}
