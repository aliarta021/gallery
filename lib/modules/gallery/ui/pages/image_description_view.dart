import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revolution1401/common/localization/locale_keys.g.dart';
import 'package:revolution1401/common/styles/appTheme/app_theme_helper.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';

class ImageDescrptionView extends StatelessWidget {
  const ImageDescrptionView(
      {super.key, required this.snapshot, required this.index});

  final AsyncSnapshot<QuerySnapshot> snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 28.0, horizontal: 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: CachedNetworkImage(
                fadeInCurve: Curves.bounceInOut,
                fadeInDuration: const Duration(seconds: 3),
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
            ),
          ),
          const SizedBox(height: 12,),
          Text(snapshot.data?.docs[index]['title'], style: context.textTheme.titleLarge,),
          const SizedBox(height: 12,),
          // DraggableScrollableSheet(
          //   initialChildSize: 0.38,
          //   minChildSize: 0.38,
          //   expand: true,
          //   maxChildSize: 0.52,
          //   // snap: true,
          //   snapAnimationDuration: const Duration(microseconds: 500),
          //   builder: (BuildContext context, ScrollController scrollController) {
          //     return Container(
          //       padding: const EdgeInsets.all(12),
          //       margin: const EdgeInsets.only(top: 12),
          //       decoration: const BoxDecoration(
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(28),
          //           topRight: Radius.circular(28),
          //         ),
          //       ),
          //       child: SingleChildScrollView(
          //         controller: scrollController,
          //         child: Column(
          //           children: [
          //             Row(
          //               children: [
          //                 Text(
          //                   '${LocaleKeys.title.tr()} : ',
          //                   style: context.textTheme.titleMedium,
          //                 ),
          //                 Text(
          //                   snapshot.data?.docs[index]['title'],
          //                   style: context.textTheme.bodyLarge,
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
