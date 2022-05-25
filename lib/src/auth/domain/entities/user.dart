import 'package:firebase_auth_starter/src/auth/domain/entities/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required UniqueId id,
    String? name,
    String? email,
    String? imageUrl,
  }) = _User;
}
