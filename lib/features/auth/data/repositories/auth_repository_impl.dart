import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/register_use_case.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> login(LoginParams params) async {
    return await _handleAuthCall(() => remoteDataSource.login(params));
  }

  @override
  Future<Either<Failure, UserEntity>> register(RegisterParams params) async {
    return await _handleAuthCall(() => remoteDataSource.register(params));
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    return await _handleAuthCall(() => remoteDataSource.forgotPassword(email));
  }

  @override
  Future<Either<Failure, bool>> checkOtpRequirement(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.checkOtpRequirement(email);
        return Right(result);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> googleSignIn() async {
    return await _handleAuthCall(() => remoteDataSource.googleSignIn());
  }

  @override
  Future<Either<Failure, UserEntity>> appleSignIn() async {
    return await _handleAuthCall(() => remoteDataSource.appleSignIn());
  }

  Future<Either<Failure, T>> _handleAuthCall<T>(
    Future<T> Function() call,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await call();
        return Right(result);
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}
