import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';

class ImageDescrptionView extends StatelessWidget {
  const ImageDescrptionView(
      {super.key, required this.snapshot, required this.index});

  final AsyncSnapshot<QuerySnapshot> snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            color: context.colors.success,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.78,
            minChildSize: 0.78,
            expand: true,
            snap: true,
            snapAnimationDuration: const Duration(microseconds: 500),
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                // margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: context.colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(snapshot.data?.docs[index]['image_url']),
              );
            },
          ),
        ],
      ),
    );
  }
}
