import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_city_app/services/storage_base.dart';

class FirebaseStorageService implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<String> uploadFile(
      String userID, String fileType, File yuklenecekDosya) async {
    Reference reference =
        _firebaseStorage.ref().child("users").child(userID).child(fileType);
    reference.putFile(yuklenecekDosya);

    String url = await reference.getDownloadURL();
    return url;
  }
}
