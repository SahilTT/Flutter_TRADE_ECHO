import '../models/auth_model.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/register_use_case.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(LoginParams params);
  Future<AuthModel> register(RegisterParams params);
  Future<void> forgotPassword(String email);
  Future<bool> checkOtpRequirement(String email);
  Future<AuthModel> googleSignIn();
  Future<AuthModel> appleSignIn();
}
