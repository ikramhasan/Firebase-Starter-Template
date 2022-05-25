import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_auth_starter/src/auth/domain/entities/user.dart';
import 'package:firebase_auth_starter/src/auth/domain/entities/value_objects.dart';

extension FirebaseUserX on firebase.User {
  User toDomain() {
    return User(
      id: UniqueId.fromUniqueString(uid),
      email: email,
      imageUrl: photoURL,
      name: displayName,
    );
  }
}
