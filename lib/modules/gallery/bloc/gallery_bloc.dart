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

  bool checkImage(AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    List<int> group =  snapshot.data?.docs[index]['grouping'];
    return (group.asMap().containsKey(GroupType.images.intGroupType()));
  }
}
