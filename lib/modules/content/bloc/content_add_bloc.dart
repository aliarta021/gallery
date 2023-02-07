import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContentAddBloc extends ChangeNotifier {
  final storageRef = FirebaseStorage.instance.ref();
  String? urlImage;

  Future<void> selectFile(XFile? file) async {
    Reference? imagesRef = storageRef.child("gallery");
    if (file != null) {
      String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
      final refrenceDirImage = imagesRef.child(uniqueName);
      await refrenceDirImage.putFile(File(file.path));
      urlImage = await refrenceDirImage.getDownloadURL();
      // final path = refrenceDirImage.fullPath;
      // final name = refrenceDirImage.name;
      // imagesRef = refrenceDirImage.parent;
    }
  }
}
