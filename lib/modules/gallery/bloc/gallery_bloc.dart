import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:revolution1401/common/resources/resources.dart';
import 'package:revolution1401/modules/content/enums/group_type.dart';

class GalleryBloc extends ChangeNotifier {
  List<String> imageList = [
    Images.dena,
    Images.initialBackground,
    Images.hadise,
    Images.hosna,
    Images.mahbobe,
    Images.meydanAzadi,
    Videos.ghalamfarsa1,
  ];

  List? grouping;

  bool checkImage(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    setGroupingList(snapshot, index);
    List<int> converted = [];
    grouping?.forEach((element) {
      converted.add(element ?? 0);
    });
    if (grouping != null) {
      return (grouping!.contains(GroupType.images.intGroupType()));
    } else {
      return false;
    }
  }

  Future<void> setGroupingList(
      AsyncSnapshot<QuerySnapshot> snapshot, int index) async {
    grouping = snapshot.data?.docs[index]['grouping'];
  }
}
