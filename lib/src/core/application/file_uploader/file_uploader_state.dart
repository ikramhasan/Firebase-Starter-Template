part of 'file_uploader_cubit.dart';

@freezed
class FileUploaderState with _$FileUploaderState {
  const factory FileUploaderState({
    required bool loading,
    required bool uploaded,
    required Failure failure,
    required String downloadUrl,
  }) = _FileUploaderState;

  factory FileUploaderState.initial() => _FileUploaderState(
        loading: false,
        downloadUrl: '',
        failure: Failure.none(),
        uploaded: false,
      );
}
