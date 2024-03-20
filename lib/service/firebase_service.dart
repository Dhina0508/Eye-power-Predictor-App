// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseService {
  static Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000)}.jpg';

      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images')
          .child(fileName);

      firebase_storage.SettableMetadata metadata =
          firebase_storage.SettableMetadata(contentType: 'image/jpeg');

      await ref.putFile(imageFile, metadata);

      String downloadURL = await ref.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
