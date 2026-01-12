import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/register_use_case.dart';
import '../../domain/usecases/forgot_password_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.forgotPasswordUseCase,
  }) : super(const AuthState()) {
    on<EmailChanged>(_onEmailChanged);
    on<FullNameChanged>(_onFullNameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<TermsAcceptedChanged>(_onTermsAcceptedChanged);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<ToggleConfirmPasswordVisibility>(_onToggleConfirmPasswordVisibility);
    on<PasswordFocusChanged>(_onPasswordFocusChanged);
    on<SignInSubmitted>(_onSignInSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<ForgotPasswordSubmitted>(_onForgotPasswordSubmitted);
    on<AuthStatusReset>(_onAuthStatusReset);
  }

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) {
    final email = event.email;
    final isEmailValid = GetUtils.isEmail(email);
    emit(
      state.copyWith(
        email: email,
        isEmailValid: isEmailValid,
        clearEmailError: isEmailValid,
      ),
    );
  }

  void _onFullNameChanged(FullNameChanged event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        fullName: event.fullName,
        clearFullNameError: event.fullName.isNotEmpty,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    final password = event.password;
    final hasMinLength = password.length >= 8;
    emit(
      state.copyWith(
        password: password,
        hasMinLength: hasMinLength,
        hasUppercase: password.contains(RegExp(r'[A-Z]')),
        hasNumber: password.contains(RegExp(r'[0-9]')),
        hasSpecialChar: password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
        clearPasswordError: hasMinLength,
      ),
    );
  }

  void _onConfirmPasswordChanged(
    ConfirmPasswordChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        confirmPassword: event.confirmPassword,
        clearConfirmPasswordError: event.confirmPassword == state.password,
      ),
    );
  }

  void _onTermsAcceptedChanged(
    TermsAcceptedChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isTermsAccepted: event.isAccepted));
  }

  void _onPasswordFocusChanged(
    PasswordFocusChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isPasswordEditing: event.hasFocus));
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onToggleConfirmPasswordVisibility(
    ToggleConfirmPasswordVisibility event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }

  Future<void> _onSignInSubmitted(
    SignInSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (state.email.isEmpty || !state.isEmailValid) {
      emit(state.copyWith(emailError: 'Invalid email'));
      return;
    }
    if (state.password.length < 8) {
      emit(state.copyWith(passwordError: 'Password too short'));
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading));

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    final result = await loginUseCase(
      LoginParams(email: state.email, password: state.password),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (user) => emit(
        state.copyWith(
          status: AuthStatus.success,
          user: user,
          successMessage: 'Signed in successfully!',
        ),
      ),
    );
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (state.fullName.isEmpty) {
      emit(state.copyWith(fullNameError: 'Full name is required'));
      return;
    }
    if (state.email.isEmpty || !state.isEmailValid) {
      emit(state.copyWith(emailError: 'Invalid email'));
      return;
    }
    if (state.password.length < 8) {
      emit(state.copyWith(passwordError: 'Password too short'));
      return;
    }
    if (state.confirmPassword != state.password) {
      emit(state.copyWith(confirmPasswordError: 'Passwords do not match'));
      return;
    }
    if (!state.isTermsAccepted) {
      emit(state.copyWith(errorMessage: 'Please accept the Terms of Service'));
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading));

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulated Success
    emit(
      state.copyWith(
        status: AuthStatus.success,
        successMessage: 'Registration successful!',
      ),
    );
  }

  Future<void> _onForgotPasswordSubmitted(
    ForgotPasswordSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    if (state.email.isEmpty || !state.isEmailValid) {
      emit(state.copyWith(emailError: 'Invalid email'));
      return;
    }

    emit(state.copyWith(status: AuthStatus.loading));

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // Simulated Success
    emit(
      state.copyWith(
        status: AuthStatus.success,
        successMessage: 'Reset link sent to your email!',
      ),
    );
  }

  void _onAuthStatusReset(AuthStatusReset event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        status: AuthStatus.initial,
        clearErrorMessage: true,
        clearSuccessMessage: true,
      ),
    );
  }
}
