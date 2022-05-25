import 'package:bloc/bloc.dart';
import 'package:firebase_auth_starter/src/auth/domain/interfaces/i_auth_repository.dart';
import 'package:firebase_auth_starter/src/auth/infrastructure/user_dtos.dart';
import 'package:firebase_auth_starter/src/core/domain/entities/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'user_info_state.dart';
part 'user_info_cubit.freezed.dart';

@injectable
class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit(this._authRepository) : super(UserInfoState.initial());

  final IAuthRepository _authRepository;

  Future<void> getUserInfo() async {
    _getUserInfo();
  }

  Future<void> setUserInfo() async {
    emit(state.copyWith(loading: true, failure: Failure.none()));

    if (state.name.isNotEmpty &&
        !RegExp(r'[!@#<>?":_`~;[\]\|=+)(*&^%0-9-]').hasMatch(state.name)) {
      final failureOrUserCreated = await _authRepository.setUserInfo(
        name: state.name,
        imageUrl: state.imageUrl,
      );

      emit(
        failureOrUserCreated.fold(
          (failure) => state.copyWith(
            failure: failure,
            created: false,
          ),
          (_) => state.copyWith(
            created: true,
            failure: Failure.none(),
          ),
        ),
      );

      _getUserInfo();
    }

    emit(state.copyWith(loading: false, showErrorMessages: true));
  }

  void nameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void setImageUrl(String image) {
    emit(state.copyWith(imageUrl: image));
  }

  Future<void> _getUserInfo() async {
    emit(state.copyWith(loading: true, failure: Failure.none()));

    final failureOrUser = await _authRepository.getUserInfo();
    emit(state.copyWith(loading: false));

    emit(
      failureOrUser.fold(
        (failure) => state.copyWith(
          failure: failure,
          user: UserDto.empty(),
        ),
        (user) => state.copyWith(
          user: user,
          failure: Failure.none(),
        ),
      ),
    );
  }

  void flush() {
    emit(UserInfoState.initial());
  }
}
