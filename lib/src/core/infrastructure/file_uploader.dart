import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth_starter/src/core/domain/entities/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth_starter/src/core/domain/interfaces/i_file_uploader.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IFileUploader)
class FileUploader implements IFileUploader {
  final FirebaseStorage _storage;

  FileUploader(this._storage);

  @override
  Future<Either<Failure, String>> uploadImage(String location) async {
    try {
      final pickedFile = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
        allowCompression: true,
      );

      if (pickedFile == null) {
        return left(
          const Failure(
            message: 'Please choose an image to continue',
            code: 404,
          ),
        );
      }

      final image = pickedFile.files.first;
      final path =
          '$location/${DateTime.now().millisecondsSinceEpoch} - ${image.name}';

      final imageFile = File(image.path!);
      final downloadUrl = await _uploadFileToStorage(imageFile, path);

      return right(downloadUrl);
    } catch (e) {
      print(e);
      return left(Failure.general());
    }
  }

  Future<String> _uploadFileToStorage(File file, String path) async {
    final ref = _storage.ref().child(path);
    final uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() => null);

    return await snapshot.ref.getDownloadURL();
  }
}
