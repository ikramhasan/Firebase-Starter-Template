import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_starter/src/auth/domain/interfaces/i_auth_repository.dart';
import 'package:firebase_auth_starter/src/auth/infrastructure/user_dtos.dart';
import 'package:firebase_auth_starter/src/core/domain/entities/failure.dart';
import 'package:firebase_auth_starter/src/core/infrastructure/firestore_helpers.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firestore, this._firebaseAuth);

  @override
  Future<Either<Failure, Unit>> setUserInfo({
    required String name,
    required String imageUrl,
  }) async {
    try {
      final userDoc = await _firestore.userDocument();

      final user = UserDto(
        id: _firebaseAuth.currentUser!.uid,
        name: name,
        email: _firebaseAuth.currentUser!.email!,
        imageUrl: imageUrl,
      );

      await _firebaseAuth.currentUser?.updateDisplayName(user.name);
      await _firebaseAuth.currentUser?.updatePhotoURL(user.imageUrl);

      await userDoc.set(user.toJson());

      return right(unit);
    } catch (e) {
      return left(
        const Failure(
          message: 'Something went wrong!',
          code: 404,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserDto>> getUserInfo() async {
    try {
      final userDoc = await _firestore.userDocument();

      final userDocument = await userDoc.get();
      if (userDocument.data() != null) {
        final userMap = userDocument.data() as Map<String, dynamic>;

        return right(UserDto.fromJson(userMap));
      }

      return right(UserDto.empty());
    } catch (e) {
      print(e);
      return left(
        const Failure(
          message: 'Could not fetch user data',
          code: 404,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> saveGoogleUserToDatabase() async {
    try {
      final userDoc = await _firestore.userDocument();

      final user = UserDto(
        id: _firebaseAuth.currentUser!.uid,
        name: _firebaseAuth.currentUser!.displayName!,
        email: _firebaseAuth.currentUser!.email!,
        imageUrl: _firebaseAuth.currentUser!.photoURL!,
      );

      await userDoc.set(user.toJson());

      return right(unit);
    } on FirebaseException catch (e) {
      return left(
        Failure(
          message: e.message ?? 'Something went wrong!',
          code: 404,
        ),
      );
    } catch (e) {
      return left(
        const Failure(
          message: 'Something went wrong!',
          code: 404,
        ),
      );
    }
  }
}
