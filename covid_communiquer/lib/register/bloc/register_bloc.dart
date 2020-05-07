import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';

import 'package:covid_communiquer/repository/user_repository.dart';
import 'package:covid_communiquer/validators.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
    Stream<RegisterEvent> events,
    TransitionFunction<RegisterEvent, RegisterState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged &&
          event is! PasswordChanged &&
          event is ! PinCodeChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged ||
          event is PasswordChanged ||
          event is PinCodeChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is PinCodeChanged) {
      yield* _mapPinCodeChangedToState(event.pinCode);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
        event.userName,
        event.firstName,
        event.lastName,
        event.email,
        event.password,
        event.streetAddress,
        event.locality,
        event.city,
        event.state,
        event.pinCode
      );
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapPinCodeChangedToState(int pinCode) async* {
    yield state.update(
      isPinCodeValid: Validators.isPinCodeValid(pinCode)
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String userName,
    String firstName,
    String lastName,
    String email,
    String password,
    String streetAddress,
    String locality,
    String city,
    String state,
    int pinCode
  ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
        userName: userName,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        streetAddress: streetAddress,
        locality: locality,
        city: city,
        state: state,
        pinCode: pinCode
      );
      yield RegisterState.success();
    } catch (error) {
      yield RegisterState.failure();
    }
  }
}
