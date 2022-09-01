import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  Reference get firebaseStorageRef => FirebaseStorage.instance.ref();

  Future<void> uploadImageToFirebaseStorage(String path, File imageFile) async {
    final imageCount = await firebaseStorageRef.child('Images/$path').listAll().then((value) => value.items.length);
    final image =
        await firebaseStorageRef.child('Images/$path/$path-${(imageCount + 1).toString()}').putFile(imageFile);
    print(imageCount);
  }

  Future<void> uploadExcelFiletoFirebaseStorage(String excelFileName, File excelFile) async {
    final excelFileUpload = await firebaseStorageRef.child('Files/$excelFileName').putFile(excelFile);
  }

}
