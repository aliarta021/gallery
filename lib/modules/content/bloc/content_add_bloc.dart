import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revolution1401/common/utils/logging/log_helper.dart';

class ContentAddBloc extends ChangeNotifier {
  final storageRef = FirebaseStorage.instance.ref();
  String? urlImage;

  Future<void> selectFile(XFile? file) async {
    Reference? imagesRef = storageRef.child("gallery");
    if (file != null) {
      try {
        String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
        final refrenceDirImage = imagesRef.child(uniqueName);
        await refrenceDirImage.putFile(File(file.path));
        urlImage = await refrenceDirImage.getDownloadURL();
        print(urlImage);
        notifyListeners();
      } catch (e) {
        e.log();
      }

      // final path = refrenceDirImage.fullPath;
      // final name = refrenceDirImage.name;
      // imagesRef = refrenceDirImage.parent;
    }
  }
}
