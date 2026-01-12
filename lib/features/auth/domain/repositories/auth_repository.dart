import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_entity.dart';
import '../usecases/login_use_case.dart';
import '../usecases/register_use_case.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(LoginParams params);
  Future<Either<Failure, UserEntity>> register(RegisterParams params);
  Future<Either<Failure, void>> forgotPassword(String email);
  Future<Either<Failure, bool>> checkOtpRequirement(String email);
  Future<Either<Failure, UserEntity>> googleSignIn();
  Future<Either<Failure, UserEntity>> appleSignIn();
}
