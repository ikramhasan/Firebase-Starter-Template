import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dtos.freezed.dart';
part 'user_dtos.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    String? id,
    String? name,
    String? email,
    String? imageUrl,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  factory UserDto.empty() => const _UserDto(
        id: '',
        email: '',
        imageUrl: '',
        name: '',
      );
}
