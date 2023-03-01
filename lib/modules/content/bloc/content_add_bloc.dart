import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:revolution1401/common/utils/logging/log_helper.dart';
import 'package:revolution1401/common/utils/toast.dart';
import 'package:revolution1401/modules/content/enums/group_type.dart';
import 'package:revolution1401/modules/content/models/content_model.dart';
import 'package:revolution1401/modules/database/bloc/database_bloc.dart';

class ContentAddBloc extends ChangeNotifier {
  final storageRef = FirebaseStorage.instance.ref();
  UploadTask? _uploadTask;
  UploadTask? get uploadTask => _uploadTask;
  set uploadTask(UploadTask? value) {
    _uploadTask = value;
    notifyListeners();
  }

  List<int> _groupSelectedList = [];

  List<int> get groupSelectedList => _groupSelectedList;

  set groupSelectedList(List<int> value) {
    _groupSelectedList = value;
    notifyListeners();
  }

  void checkGroup(bool? value, int index) {
    (value ?? false)
        ? groupSelectedList.add((index + 1))
        : groupSelectedList.remove((index + 1));
    notifyListeners();
  }

  List<GroupType> groupTypeList = [
    GroupType.deceased,
    GroupType.prison,
    GroupType.art,
    GroupType.videos,
    GroupType.images,
  ];

  String? urlImage;

  PlatformFile? file;

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    file = result?.files.first;
    notifyListeners();
  }

  Future<void> uploadFile({
    PlatformFile? file,
    String? title,
    String? description,
    int? arrestDate,
    int? deathDate,
    int? freedomDate,
  }) async {
    Reference? imagesRef = storageRef.child("gallery");
    if (file != null) {
      try {
        String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
        final refrenceDirImage = imagesRef.child(uniqueName);
        uploadTask = refrenceDirImage.putFile(File(file.path ?? ''));
        //todo :: check this
        uploadTask?.snapshotEvents.listen((TaskSnapshot snapshot) {
          print('Task state: ${snapshot.state}');
          print(
              'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
          switch (snapshot.state) {
            case TaskState.paused:
              break;
            case TaskState.running:
              CircularProgressIndicator(
                  value:
                      (snapshot.bytesTransferred > 0 && snapshot.totalBytes > 0)
                          ? snapshot.bytesTransferred / snapshot.totalBytes
                          : null);

              // showPercent(snapshot, title, description, freedomDate, deathDate,
              //     arrestDate);
              break;
            case TaskState.success:
              print('success');
              break;
            case TaskState.canceled:
              break;
            case TaskState.error:
              snapshot.errLog();
              break;
          }
        }, onError: (e) {
          // The final snapshot is also available on the status via `.snapshot`,
          // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
          print(uploadTask?.snapshot);
        });

        // await uploadTask?.whenComplete(() => {print('upload complete')});
        urlImage = await uploadTask?.snapshot.ref.getDownloadURL();
        await addToDatabase(
          arrestDate: arrestDate,
          deathDate: deathDate,
          description: description,
          freedomDate: freedomDate,
          title: title,
        )
            ? Toast.show('آپلود با موفقیت انجام شد.')
            : Toast.show('آپلود موفقیت آمیز نبود لطفا دوباره تلاش کنید.');
        uploadTask = null;
        clearData(title, description, arrestDate, deathDate, freedomDate);
        notifyListeners();
      } catch (e) {
        e.log();
      }
      // final path = refrenceDirImage.fullPath;
      // final name = refrenceDirImage.name;
      // imagesRef = refrenceDirImage.parent;
    }
  }

  Future<void> showPercent(
    TaskSnapshot snapshot,
    String? title,
    String? description,
    int? arrestDate,
    int? deathDate,
    int? freedomDate,
  ) async {
    CircularProgressIndicator(
        value: (snapshot.bytesTransferred > 0 && snapshot.totalBytes > 0)
            ? snapshot.bytesTransferred / snapshot.totalBytes
            : null);
    urlImage = await snapshot.ref.getDownloadURL();
    await addToDatabase(
      arrestDate: arrestDate,
      deathDate: deathDate,
      description: description,
      freedomDate: freedomDate,
      title: title,
    )
        ? Toast.show('آپلود با موفقیت انجام شد.')
        : Toast.show('آپلود موفقیت آمیز نبود لطفا دوباره تلاش کنید.');
    uploadTask = null;
    clearData(title, description, arrestDate, deathDate, freedomDate);
  }

  void clearData(
    String? title,
    String? description,
    int? arrestDate,
    int? deathDate,
    int? freedomDate,
  ) {
    file = null;
    title = '';
    arrestDate = null;
    deathDate = null;
    freedomDate = null;
    urlImage = null;
  }

  Future<bool> addToDatabase({
    String? title,
    String? description,
    int? arrestDate,
    int? deathDate,
    int? freedomDate,
  }) async {
    try {
      if (urlImage != null && urlImage!.isNotEmpty && title != null) {
        ContentModel model = ContentModel(
          imageUrl: urlImage,
          arrestDate: arrestDate,
          deathDate: deathDate,
          freedomDate: freedomDate,
          grouping: groupSelectedList,
          title: title,
          description: description,
        );
        //todo: check it
        DatabaseBloc().refrence.add(model.toJson());
        return true;
      }
      return true;
    } catch (e) {
      e.log();
      return true;
    }
  }

  // Future<void> load() async {
  //   Database snapshot = await refrence.;
  //   snapshot.wtfLog();
  //   print(snapshot.metadata.);
  //   // print(_refrence.get().then((DataSnap) => null));
  // }
}
