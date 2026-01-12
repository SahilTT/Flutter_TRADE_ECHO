import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/register_use_case.dart';
import '../models/auth_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth? firebaseAuth;
  final Dio dio;

  AuthRemoteDataSourceImpl({this.firebaseAuth, required this.dio});

  @override
  Future<AuthModel> login(LoginParams params) async {
    debugPrint("Simulating API Hit to ${AppConstants.BASE_URL}/login");
    await Future.delayed(const Duration(seconds: 2));

    try {
      if (firebaseAuth != null) {
        final userCredential = await firebaseAuth!.signInWithEmailAndPassword(
          email: params.email,
          password: params.password,
        );
        final idToken = await userCredential.user?.getIdToken();
        return AuthModel(
          id: userCredential.user?.uid ?? '',
          email: userCredential.user?.email ?? '',
          fullname: userCredential.user?.displayName ?? '',
          isTermsAccepted: true,
          accessToken: idToken,
        );
      }
    } catch (e) {
      debugPrint("Firebase Login error (falling back to simulation): $e");
    }

    // Simulation fallback
    return AuthModel(
      id: 'simulated_id',
      email: params.email,
      fullname: 'Simulated User',
      isTermsAccepted: true,
      accessToken: 'simulated_token',
    );
  }

  @override
  Future<AuthModel> register(RegisterParams params) async {
    debugPrint("Simulating API Hit to ${AppConstants.BASE_URL}/register");
    await Future.delayed(const Duration(seconds: 2));

    try {
      if (firebaseAuth != null) {
        final userCredential = await firebaseAuth!
            .createUserWithEmailAndPassword(
              email: params.email,
              password: params.password,
            );
        await userCredential.user?.updateDisplayName(params.fullName);
        final idToken = await userCredential.user?.getIdToken();
        return AuthModel(
          id: userCredential.user?.uid ?? '',
          email: userCredential.user?.email ?? '',
          fullname: params.fullName,
          isTermsAccepted: true,
          accessToken: idToken,
        );
      }
    } catch (e) {
      debugPrint("Firebase Register error (falling back to simulation): $e");
    }

    // Simulation fallback
    return AuthModel(
      id: 'simulated_id',
      email: params.email,
      fullname: params.fullName,
      isTermsAccepted: true,
      accessToken: 'simulated_token',
    );
  }

  @override
  Future<void> forgotPassword(String email) async {
    debugPrint(
      "Simulating API Hit to ${AppConstants.BASE_URL}/forgot-password",
    );
    await Future.delayed(const Duration(seconds: 2));

    try {
      if (firebaseAuth != null) {
        await firebaseAuth!.sendPasswordResetEmail(email: email);
      }
    } catch (e) {
      debugPrint(
        "Firebase ForgotPassword error (falling back to simulation): $e",
      );
    }
  }

  @override
  Future<bool> checkOtpRequirement(String email) async {
    try {
      // Simulation: no OTP required for now
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<AuthModel> googleSignIn() async {
    throw UnimplementedError();
  }

  @override
  Future<AuthModel> appleSignIn() async {
    throw UnimplementedError();
  }
}
