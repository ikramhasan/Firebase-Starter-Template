import 'package:dartz/dartz.dart';
import 'package:firebase_auth_starter/src/auth/infrastructure/user_dtos.dart';
import 'package:firebase_auth_starter/src/core/domain/entities/failure.dart';

abstract class IAuthRepository {
  Future<Either<Failure, Unit>> setUserInfo({
    required String name,
    required String imageUrl,
  });

  Future<Either<Failure, UserDto>> getUserInfo();

  Future<Either<Failure, Unit>> saveGoogleUserToDatabase();
}
