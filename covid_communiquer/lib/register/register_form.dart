import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:covid_communiquer/bloc/authentication_bloc.dart';
import 'package:covid_communiquer/register/bloc/register_bloc.dart';
import 'package:covid_communiquer/register/register_button.dart';

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  static const STATE_DROPDOWN_MENU_ITEMS = [
    DropdownMenuItem(
        value: "Andhra Pradesh", child: const Text("Andhra Pradesh")),
    DropdownMenuItem(
        value: "Arunachal Pradesh ", child: const Text("Arunachal Pradesh ")),
    DropdownMenuItem(value: "Assam", child: const Text("Assam")),
    DropdownMenuItem(value: "Bihar", child: const Text("Bihar")),
    DropdownMenuItem(value: "Chhattisgarh", child: const Text("Chhattisgarh")),
    DropdownMenuItem(value: "Goa", child: const Text("Goa")),
    DropdownMenuItem(value: "Gujarat", child: const Text("Gujarat")),
    DropdownMenuItem(value: "Haryana", child: const Text("Haryana")),
    DropdownMenuItem(
        value: "Himachal Pradesh", child: const Text("Himachal Pradesh")),
    DropdownMenuItem(
        value: "Jammu and Kashmir ", child: const Text("Jammu and Kashmir ")),
    DropdownMenuItem(value: "Jharkhand", child: const Text("Jharkhand")),
    DropdownMenuItem(value: "Karnataka", child: const Text("Karnataka")),
    DropdownMenuItem(value: "Kerala", child: const Text("Kerala")),
    DropdownMenuItem(
        value: "Madhya Pradesh", child: const Text("Madhya Pradesh")),
    DropdownMenuItem(value: "Maharashtra", child: const Text("Maharashtra")),
    DropdownMenuItem(value: "Manipur", child: const Text("Manipur")),
    DropdownMenuItem(value: "Meghalaya", child: const Text("Meghalaya")),
    DropdownMenuItem(value: "Mizoram", child: const Text("Mizoram")),
    DropdownMenuItem(value: "Nagaland", child: const Text("Nagaland")),
    DropdownMenuItem(value: "Odisha", child: const Text("Odisha")),
    DropdownMenuItem(value: "Punjab", child: const Text("Punjab")),
    DropdownMenuItem(value: "Rajasthan", child: const Text("Rajasthan")),
    DropdownMenuItem(value: "Sikkim", child: const Text("Sikkim")),
    DropdownMenuItem(value: "Tamil Nadu", child: const Text("Tamil Nadu")),
    DropdownMenuItem(value: "Telangana", child: const Text("Telangana")),
    DropdownMenuItem(value: "Tripura", child: const Text("Tripura")),
    DropdownMenuItem(
        value: "Uttar Pradesh", child: const Text("Uttar Pradesh")),
    DropdownMenuItem(value: "Uttarakhand", child: const Text("Uttarakhand")),
    DropdownMenuItem(value: "West Bengal", child: const Text("West Bengal")),
    DropdownMenuItem(
        value: "Andaman and Nicobar Islands",
        child: const Text("Andaman and Nicobar Islands")),
    DropdownMenuItem(value: "Chandigarh", child: const Text("Chandigarh")),
    DropdownMenuItem(
        value: "Dadra and Nagar Haveli",
        child: const Text("Dadra and Nagar Haveli")),
    DropdownMenuItem(
        value: "Daman and Diu", child: const Text("Daman and Diu")),
    DropdownMenuItem(value: "Lakshadweep", child: const Text("Lakshadweep")),
    DropdownMenuItem(
        value: "National Capital Territory of Delhi",
        child: const Text("National Capital Territory of Delhi")),
    DropdownMenuItem(value: "Puducherry", child: const Text("Puducherry")),
  ];

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _localityAddressController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  var _state = "Andhra Pradesh";
  final TextEditingController _pinCodeController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _userNameController.text.isNotEmpty &&
      _firstNameController.text.isNotEmpty &&
      _lastNameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _pinCodeController.addListener(_onPinCodeChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _userNameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Username',
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isUsernameValid ? 'Invalid Username' : null;
                    },
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person_outline),
                      labelText: 'First Name',
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isFirstNameValid
                          ? 'Invalid First Name'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person_outline),
                      labelText: 'Last Name',
                    ),
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isLastNameValid
                          ? 'Invalid Last Name'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  TextFormField(
                    controller: _streetAddressController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.local_post_office),
                      labelText: 'Street Address',
                    ),
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isStreetAddressValid
                          ? 'Invalid Street Address'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: _localityAddressController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.local_post_office),
                      labelText: 'Locality',
                    ),
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isLocalityValid ? 'Invalid Locality' : null;
                    },
                  ),
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.local_post_office),
                      labelText: 'City',
                    ),
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isCityValid ? 'Invalid City' : null;
                    },
                  ),
                  InputDecorator(
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.redAccent),
                      icon: Icon(Icons.local_post_office),
                      hintText: 'Select State',
                      labelText: 'Select State',
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        items: STATE_DROPDOWN_MENU_ITEMS,
                        value: _state,
                        isDense: true,
                        onChanged: (String value) {
                          setState(() {
                            this._state = value;
                          });
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _pinCodeController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.code),
                      labelText: 'Pin Code',
                    ),
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isPinCodeValid ? 'Invalid Pin Code' : null;
                    },
                  ),
                  RegisterButton(
                    onPressed: isRegisterButtonEnabled(state)
                        ? _onFormSubmitted
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onPinCodeChanged() {
    _registerBloc.add(
      PinCodeChanged(pinCode: int.parse(_pinCodeController.text)),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
          userName: _userNameController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          streetAddress: _streetAddressController.text,
          locality: _localityAddressController.text,
          city: _cityController.text,
          state: _state,
          pinCode: int.parse(_pinCodeController.text)),
    );
  }
}
