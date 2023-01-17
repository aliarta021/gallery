import 'package:flutter/cupertino.dart';
import 'package:revolution1401/common/file_model.dart';
import 'package:revolution1401/common/models/image_model.dart';
import 'package:revolution1401/common/models/multiLanguage/multi_language_file.dart';
import 'package:revolution1401/common/resources/resources.dart';
import 'package:revolution1401/modules/home/models/banner_model.dart';

class HomeBloc extends ChangeNotifier {
  List<BannerModel> list = [
    BannerModel(
      name: 'Hadise',
      description: 'hadise',
      image: ImageModel(
          mobile: MultiLanguageFile(
        fa: FileModel(
          hashKey: Images.hadise,
          id: 'hadise',
          meta: FileMeta(size: 250),
        ),
      )),
    ),
    BannerModel(
      name: 'Dena',
      description: 'dena',
      image: ImageModel(
          mobile: MultiLanguageFile(
        fa: FileModel(
          hashKey: Images.dena,
          id: 'dena',
          meta: FileMeta(size: 250),
        ),
      )),
    ),
    BannerModel(
      name: 'hosna',
      description: 'hosna',
      image: ImageModel(
          mobile: MultiLanguageFile(
        fa: FileModel(
          hashKey: Images.hosna,
          id: 'hosna',
          meta: FileMeta(size: 250),
        ),
      )),
    ),
    BannerModel(
      name: 'mahbobe',
      description: 'mahbobe',
      image: ImageModel(
          mobile: MultiLanguageFile(
        fa: FileModel(
          hashKey: Images.mahbobe,
          id: 'mahbobe',
          meta: FileMeta(size: 250),
        ),
      )),
    ),
  ];
}
