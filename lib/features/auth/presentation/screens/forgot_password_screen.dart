import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/theme/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/common_dark_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: true,
        bottom: false,
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
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
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
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              const Text(
                                "Forgot Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Enter your email address and we'll send you a link to reset your password.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
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
                              const SizedBox(height: 20),

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
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: state.status == AuthStatus.loading
                                      ? null
                                      : () {
                                          context.read<AuthBloc>().add(
                                            ForgotPasswordSubmitted(),
                                          );
                                        },
                                  child: state.status == AuthStatus.loading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          "Continue",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 5),

                              TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text(
                                  "Back to login",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
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
}
