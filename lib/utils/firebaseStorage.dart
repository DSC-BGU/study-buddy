import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class FirabaseStorageUtils{
  static Future uploadImageToFirebase(BuildContext context, File _imageFile, fileName) async {
    firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    firebase_storage.Reference ref  = storage.ref().child('uploads/$fileName');
    firebase_storage.UploadTask uploadTask = ref.putFile(_imageFile);
  }
}