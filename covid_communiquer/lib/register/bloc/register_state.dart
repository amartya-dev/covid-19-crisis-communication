part of 'register_bloc.dart';

@immutable
class RegisterState {
  final bool isUsernameValid;
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isStreetAddressValid;
  final bool isLocalityValid;
  final bool isCityValid;
  final bool isStateValid;
  final bool isPinCodeValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid && isPinCodeValid;

  RegisterState({
    @required this.isUsernameValid,
    @required this.isFirstNameValid,
    @required this.isLastNameValid,
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isStreetAddressValid,
    @required this.isLocalityValid,
    @required this.isCityValid,
    @required this.isStateValid,
    @required this.isPinCodeValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isUsernameValid: true,
      isFirstNameValid: true,
      isLastNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isStreetAddressValid: true,
      isLocalityValid: true,
      isCityValid: true,
      isStateValid: true,
      isPinCodeValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isUsernameValid: true,
      isFirstNameValid: true,
      isLastNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isStreetAddressValid: true,
      isLocalityValid: true,
      isCityValid: true,
      isStateValid: true,
      isPinCodeValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isUsernameValid: true,
      isFirstNameValid: true,
      isLastNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isStreetAddressValid: true,
      isLocalityValid: true,
      isCityValid: true,
      isStateValid: true,
      isPinCodeValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isUsernameValid: true,
      isFirstNameValid: true,
      isLastNameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isStreetAddressValid: true,
      isLocalityValid: true,
      isCityValid: true,
      isStateValid: true,
      isPinCodeValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update({
    bool isUsernameValid,
    bool isFirstNameValid,
    bool isLastNameValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isStreetAddressValid,
    bool isLocalityValid,
    bool isCityValid,
    bool isStateValid,
    bool isPinCodeValid,
  }) {
    return copyWith(
      isUsernameValid: isUsernameValid,
      isFirstNameValid: isFirstNameValid,
      isLastNameValid: isLastNameValid,
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isStreetAddressValid: isStreetAddressValid,
      isLocalityValid: isLocalityValid,
      isCityValid: isCityValid,
      isStateValid: isStateValid,
      isPinCodeValid: isPinCodeValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isUsernameValid,
    bool isFirstNameValid,
    bool isLastNameValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isStreetAddressValid,
    bool isLocalityValid,
    bool isCityValid,
    bool isStateValid,
    bool isPinCodeValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isStreetAddressValid: isStreetAddressValid ?? this.isStreetAddressValid,
      isLocalityValid: isLocalityValid ?? this.isLocalityValid,
      isCityValid: isCityValid ?? this.isCityValid,
      isStateValid: isStateValid ?? this.isStateValid,
      isPinCodeValid: isPinCodeValid ?? this.isPinCodeValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isUsernameValid: $isUsernameValid,
      isFirstNameValid: $isFirstNameValid,
      isLastNameValid: $isLastNameValid,
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isStreesAddressValid: $isStreetAddressValid,
      isLocalityValid: $isLocalityValid,
      isCityValid: $isCityValid,
      isStateValid: $isStateValid,
      isPinCodeValid: $isPinCodeValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
