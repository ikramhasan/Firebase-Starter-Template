import 'package:dartz/dartz.dart';
import 'package:firebase_auth_starter/src/core/domain/entities/failure.dart';

abstract class IFileUploader {
  Future<Either<Failure, String>> uploadImage(String location);
}
