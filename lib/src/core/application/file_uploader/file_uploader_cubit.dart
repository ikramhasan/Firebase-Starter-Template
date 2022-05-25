import 'package:bloc/bloc.dart';
import 'package:firebase_auth_starter/src/core/domain/entities/failure.dart';
import 'package:firebase_auth_starter/src/core/domain/interfaces/i_file_uploader.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'file_uploader_state.dart';
part 'file_uploader_cubit.freezed.dart';

@injectable
class FileUploaderCubit extends Cubit<FileUploaderState> {
  FileUploaderCubit(this._fileUploader) : super(FileUploaderState.initial());

  final IFileUploader _fileUploader;

  Future<void> uploadImage(String location) async {
    emit(state.copyWith(loading: true));

    final failureOrFileUploaded = await _fileUploader.uploadImage(location);

    emit(state.copyWith(loading: false));
    emit(
      failureOrFileUploaded.fold(
        (failure) => state.copyWith(
          failure: failure,
          uploaded: false,
          downloadUrl: '',
        ),
        (downloadUrl) => state.copyWith(
          failure: Failure.none(),
          uploaded: true,
          downloadUrl: downloadUrl,
        ),
      ),
    );
  }

  void flush() {
    emit(FileUploaderState.initial());
  }
}
