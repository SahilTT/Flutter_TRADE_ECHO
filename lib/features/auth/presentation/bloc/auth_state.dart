part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final String email;
  final String password;
  final String fullName;
  final String confirmPassword;
  final bool isTermsAccepted;
  final String? emailError;
  final String? passwordError;
  final String? fullNameError;
  final String? confirmPasswordError;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasNumber;
  final bool hasSpecialChar;
  final bool isPasswordEditing;
  final AuthStatus status;
  final String? errorMessage;
  final String? successMessage;
  final UserEntity? user;
  final bool isEmailValid;

  const AuthState({
    this.email = '',
    this.password = '',
    this.fullName = '',
    this.confirmPassword = '',
    this.isTermsAccepted = false,
    this.emailError,
    this.passwordError,
    this.fullNameError,
    this.confirmPasswordError,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.hasMinLength = false,
    this.hasUppercase = false,
    this.hasNumber = false,
    this.hasSpecialChar = false,
    this.isPasswordEditing = false,
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.successMessage,
    this.user,
    this.isEmailValid = true,
  });

  AuthState copyWith({
    String? email,
    String? password,
    String? fullName,
    String? confirmPassword,
    bool? isTermsAccepted,
    String? emailError,
    bool clearEmailError = false,
    String? passwordError,
    bool clearPasswordError = false,
    String? fullNameError,
    bool clearFullNameError = false,
    String? confirmPasswordError,
    bool clearConfirmPasswordError = false,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? hasMinLength,
    bool? hasUppercase,
    bool? hasNumber,
    bool? hasSpecialChar,
    bool? isPasswordEditing,
    AuthStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? successMessage,
    bool clearSuccessMessage = false,
    UserEntity? user,
    bool? isEmailValid,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
      emailError: clearEmailError ? null : (emailError ?? this.emailError),
      passwordError: clearPasswordError
          ? null
          : (passwordError ?? this.passwordError),
      fullNameError: clearFullNameError
          ? null
          : (fullNameError ?? this.fullNameError),
      confirmPasswordError: clearConfirmPasswordError
          ? null
          : (confirmPasswordError ?? this.confirmPasswordError),
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasUppercase: hasUppercase ?? this.hasUppercase,
      hasNumber: hasNumber ?? this.hasNumber,
      hasSpecialChar: hasSpecialChar ?? this.hasSpecialChar,
      isPasswordEditing: isPasswordEditing ?? this.isPasswordEditing,
      status: status ?? this.status,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccessMessage
          ? null
          : (successMessage ?? this.successMessage),
      user: user ?? this.user,
      isEmailValid: isEmailValid ?? this.isEmailValid,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    fullName,
    confirmPassword,
    isTermsAccepted,
    emailError,
    passwordError,
    fullNameError,
    confirmPasswordError,
    isPasswordVisible,
    isConfirmPasswordVisible,
    hasMinLength,
    hasUppercase,
    hasNumber,
    hasSpecialChar,
    isPasswordEditing,
    status,
    errorMessage,
    successMessage,
    user,
    isEmailValid,
  ];
}
