import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:auth_buttons/auth_buttons.dart';
import '../../../../config/theme/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/common_dark_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    passwordFocusNode.addListener(() {
      context.read<AuthBloc>().add(
        PasswordFocusChanged(passwordFocusNode.hasFocus),
      );
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: true,
        bottom: true,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/tradeEchoBG.jpeg',
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.black),
              ),
            ),

            Center(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.manual,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/tradeEchoLogo.png",
                      height: 90,
                      width: 180,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const FlutterLogo(size: 90),
                    ),
                    const SizedBox(height: 30),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [HexColor("#061909"), HexColor("#050B07")],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade900,
                          width: 1,
                        ),
                      ),
                      child: BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state.status == AuthStatus.failure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.errorMessage ?? 'Error'),
                                backgroundColor: Colors.red,
                                duration: const Duration(milliseconds: 1500),
                              ),
                            );
                            context.read<AuthBloc>().add(AuthStatusReset());
                          } else if (state.status == AuthStatus.success &&
                              state.successMessage != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.successMessage!),
                                backgroundColor: Colors.green,
                                duration: const Duration(milliseconds: 1500),
                              ),
                            );
                            context.read<AuthBloc>().add(AuthStatusReset());
                            context.pop(); // Redirect to Login
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  20,
                                  15,
                                  20,
                                  5,
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Register",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Welcome! Get started with a free account.",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 24),
                                    CommonDarkTextField(
                                      label: "Full Name",
                                      controller: fullNameController,
                                      icon: Icons.person,
                                      isPassword: false,
                                      errorText: state.fullNameError,
                                      keyboardType: TextInputType.name,
                                      onChanged: (value) => context
                                          .read<AuthBloc>()
                                          .add(FullNameChanged(value)),
                                    ),
                                    const SizedBox(height: 15),
                                    CommonDarkTextField(
                                      label: "Email",
                                      controller: emailController,
                                      icon: Icons.email,
                                      isPassword: false,
                                      errorText: state.emailError,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) => context
                                          .read<AuthBloc>()
                                          .add(EmailChanged(value)),
                                    ),
                                    const SizedBox(height: 15),
                                    CommonDarkTextField(
                                      label: "Password",
                                      controller: passwordController,
                                      icon: Icons.lock,
                                      isPassword: true,
                                      errorText: state.passwordError,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      isPasswordVisible:
                                          state.isPasswordVisible,
                                      togglePasswordVisibility: () => context
                                          .read<AuthBloc>()
                                          .add(TogglePasswordVisibility()),
                                      onChanged: (value) => context
                                          .read<AuthBloc>()
                                          .add(PasswordChanged(value)),
                                      focusNode: passwordFocusNode,
                                    ),
                                    if (state.isPasswordEditing) ...[
                                      const SizedBox(height: 5),
                                      _buildValidationIndicator(
                                        "At least 8 characters",
                                        state.hasMinLength,
                                      ),
                                      _buildValidationIndicator(
                                        "Contains an uppercase letter",
                                        state.hasUppercase,
                                      ),
                                      _buildValidationIndicator(
                                        "Contains a number",
                                        state.hasNumber,
                                      ),
                                      _buildValidationIndicator(
                                        "Contains a special character",
                                        state.hasSpecialChar,
                                      ),
                                    ],
                                    const SizedBox(height: 15),
                                    CommonDarkTextField(
                                      label: "Confirm Password",
                                      controller: confirmPasswordController,
                                      icon: Icons.lock,
                                      isPassword: true,
                                      errorText: state.confirmPasswordError,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      isPasswordVisible:
                                          state.isConfirmPasswordVisible,
                                      togglePasswordVisibility: () =>
                                          context.read<AuthBloc>().add(
                                            ToggleConfirmPasswordVisibility(),
                                          ),
                                      onChanged: (value) => context
                                          .read<AuthBloc>()
                                          .add(ConfirmPasswordChanged(value)),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  10,
                                  20,
                                  15,
                                  20,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: state.isTermsAccepted,
                                      onChanged: (value) {
                                        context.read<AuthBloc>().add(
                                          TermsAcceptedChanged(value ?? false),
                                        );
                                      },
                                      checkColor: Colors.white,
                                      activeColor: Colors.green,
                                      fillColor:
                                          WidgetStateProperty.resolveWith<
                                            Color
                                          >((Set<WidgetState> states) {
                                            if (states.contains(
                                              WidgetState.selected,
                                            )) {
                                              return Colors.green;
                                            }
                                            return Colors.transparent;
                                          }),
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            height: 1.4,
                                          ),
                                          children: [
                                            const TextSpan(
                                              text: "I agree to the ",
                                            ),
                                            TextSpan(
                                              text: "Terms of Service and EULA",
                                              style: const TextStyle(
                                                color: Colors.green,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  // Navigate to Terms
                                                },
                                            ),
                                            const TextSpan(
                                              text:
                                                  " (Zero tolerance for objectionable content or abusive behavior).",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  20,
                                  0,
                                  20,
                                  5,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                            horizontal: 50,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        onPressed:
                                            state.status ==
                                                    AuthStatus.loading ||
                                                !state.isTermsAccepted
                                            ? null
                                            : () {
                                                context.read<AuthBloc>().add(
                                                  RegisterSubmitted(),
                                                );
                                              },
                                        child:
                                            state.status == AuthStatus.loading
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : const Text(
                                                "Register",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),

                                    SizedBox(
                                      width: double.infinity,
                                      child: GoogleAuthButton(
                                        onPressed: () {},
                                        text: "Continue with Google",
                                        style: AuthButtonStyle(
                                          buttonType: AuthButtonType.secondary,
                                          borderRadius: 10,
                                          buttonColor: Colors.white,
                                          textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          elevation: 4,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),

                                    if (Platform.isIOS)
                                      SizedBox(
                                        width: double.infinity,
                                        child: AppleAuthButton(
                                          onPressed: () {},
                                          text: "Continue with Apple",
                                          style: AuthButtonStyle(
                                            buttonType:
                                                AuthButtonType.secondary,
                                            borderRadius: 10,
                                            buttonColor: Colors.white,
                                            textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            elevation: 4,
                                          ),
                                        ),
                                      ),

                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "Already have an account?",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          child: const Text(
                                            "Sign In",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationIndicator(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isValid ? Colors.green : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 13)),
        ],
      ),
    );
  }
}
