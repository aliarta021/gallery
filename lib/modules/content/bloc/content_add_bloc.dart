import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:revolution1401/common/utils/logging/log_helper.dart';
import 'package:revolution1401/modules/content/models/content_model.dart';


class ContentAddBloc extends ChangeNotifier {
  final storageRef = FirebaseStorage.instance.ref();
  // ignore: prefer_final_fields
  CollectionReference _refrence =
      FirebaseFirestore.instance.collection('gallery_images');

  String? urlImage;

  TextEditingController? _titleController;
  
  TextEditingController? get titleController => _titleController;
  
  set titleController(TextEditingController? value) {
    _titleController = value;
    notifyListeners();
  }

  TextEditingController? _descriptonController;

  TextEditingController? get descriptonController => _descriptonController;

  set descriptonController(TextEditingController? value) {
    _descriptonController = value;
    notifyListeners();
  }

  PlatformFile? file;

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    file = result?.files.first;
    notifyListeners();
  }

  Future<void> uploadFile({PlatformFile? file, String? title,String? description,int? arrestDate,int? deathDate,int? freedomDate, List<int>? grouping}) async {
    Reference? imagesRef = storageRef.child("gallery");
    if (file != null) {
      try {
        String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
        final refrenceDirImage = imagesRef.child(uniqueName);
        await refrenceDirImage.putFile(File(file.path ?? ''));
        urlImage = await refrenceDirImage.getDownloadURL();
        if (urlImage != null &&
            urlImage!.isNotEmpty &&
            titleController != null) {
          ContentModel model = ContentModel(
            imageUrl: urlImage,
            arrestDate: arrestDate,
            deathDate: deathDate,
            freedomDate: freedomDate,
            grouping: ,
            title: titleController?.text,
            description: descriptonController?.text,
          );
          print(model.toJson());
          _refrence.add(model.toJson());
        }
        notifyListeners();
      } catch (e) {
        e.log();
      }
      // final path = refrenceDirImage.fullPath;
      // final name = refrenceDirImage.name;
      // imagesRef = refrenceDirImage.parent;
    }
  }

  Future<void> addToDatabase() async {}
}
