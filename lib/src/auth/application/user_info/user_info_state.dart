part of 'user_info_cubit.dart';

@freezed
class UserInfoState with _$UserInfoState {
  const factory UserInfoState({
    required String name,
    required String imageUrl,
    required bool loading,
    required bool created,
    required bool showErrorMessages,
    required UserDto user,
    required Failure failure,
  }) = _UserInfoState;

  factory UserInfoState.initial() => _UserInfoState(
        imageUrl: '',
        loading: true,
        name: '',
        user: UserDto.empty(),
        failure: Failure.none(),
        created: false,
        showErrorMessages: false,
      );
}
