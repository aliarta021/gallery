import 'package:easy_localization/easy_localization.dart';
import 'package:revolution1401/common/localization/locale_keys.g.dart';

enum GroupType {
  deceased, // زنده یاد
  prison, // دستگیر شده
  art, // هنر
  videos, // ویدیو
  images; // عکس

  int intGroupType() {
    switch (this) {
      case GroupType.deceased:
        return 1;
      case GroupType.prison:
        return 2;
      case GroupType.art:
        return 3;
      case GroupType.videos:
        return 4;
      case GroupType.images:
        return 5;
    }
  }
}

String? stringGroupType(int groupNumber) {
  switch (groupNumber) {
    case 1:
      return LocaleKeys.group_deceased.tr();
    case 2:
      return LocaleKeys.group_prison.tr();
    case 3:
      return LocaleKeys.group_art.tr();
    case 4:
      return LocaleKeys.group_videos.tr();
    case 5:
      return LocaleKeys.group_images.tr();
  }
  return null;
}

GroupType? groupTypeWithInt(int groupNumber) {
  switch (groupNumber) {
    case 1:
      return GroupType.deceased;
    case 2:
      return GroupType.prison;
    case 3:
      return GroupType.art;
    case 4:
      return GroupType.videos;
    case 5:
      return GroupType.images;
  }
  return null;
}
