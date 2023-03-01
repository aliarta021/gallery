import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          CachedNetworkImage(
            fadeInCurve: Curves.bounceInOut,
            fadeInDuration: Duration(seconds: 3),
            imageUrl: snapshot.data?.docs[index]['image_url'],
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Padding(
              padding: const EdgeInsets.all(18.0),
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                color: context.colors.primary,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.38,
            minChildSize: 0.38,
            expand: true,
            maxChildSize: 0.52,
            // snap: true,
            snapAnimationDuration: const Duration(microseconds: 500),
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: context.colors.success,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Text('data'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
