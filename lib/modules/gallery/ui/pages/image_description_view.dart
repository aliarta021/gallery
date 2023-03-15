import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:revolution1401/common/constants/fonts.dart';
import 'package:revolution1401/common/localization/locale_keys.g.dart';
import 'package:revolution1401/common/router/app_router.dart';
import 'package:revolution1401/common/styles/appTheme/app_theme_helper.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';
import 'package:revolution1401/common/utils/datetime_helper.dart';
import 'package:revolution1401/modules/content/enums/group_type.dart';
import 'package:revolution1401/modules/gallery/bloc/gallery_bloc.dart';
import 'package:revolution1401/modules/main/bloc/main_page_bloc.dart';

class ImageDescrptionView extends StatelessWidget {
  const ImageDescrptionView(
      {super.key, required this.snapshot, required this.index});

  final AsyncSnapshot<QuerySnapshot> snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 28.0, left: 12.0, right: 12, bottom: 12),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: CachedNetworkImage(
                    fadeInCurve: Curves.bounceInOut,
                    fadeInDuration: const Duration(seconds: 3),
                    imageUrl: snapshot.data?.docs[index]['image_url'],
                    fit: BoxFit.cover,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: context.colors.primary,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: context.colors.shadow.withOpacity(0.1)),
                      child: IconButton(
                        onPressed: () {
                        },
                        icon: const Icon(Icons.favorite_outline),
                        iconSize: 22,
                        color: context.colors.white,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: context.colors.shadow.withOpacity(0.1)),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        iconSize: 22,
                        color: context.colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (context
                        .read<GalleryBloc>()
                        .grouping!
                        .contains(GroupType.prison.intGroupType()) ||
                    context
                        .read<GalleryBloc>()
                        .grouping!
                        .contains(GroupType.deceased.intGroupType()))
                  Text(
                    '${LocaleKeys.name.tr()} : ',
                    style: context.textTheme.titleMedium,
                  ),
                if (context
                    .read<GalleryBloc>()
                    .grouping!
                    .contains(GroupType.art.intGroupType()))
                  Text(
                    '${LocaleKeys.designed.tr()} : ',
                    style: context.textTheme.titleMedium,
                  ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  snapshot.data?.docs[index]['title'],
                  style: context.textTheme.titleLarge?.copyWith(fontSize: 24),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  '${LocaleKeys.description.tr()} : ',
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(
                  width: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6.0, left: 18),
                  child: Text(
                    snapshot.data?.docs[index]['description'] ?? '',
                    style: context.textTheme.titleLarge?.copyWith(),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          if (context
              .read<GalleryBloc>()
              .grouping!
              .contains(GroupType.prison.intGroupType()))
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 22.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '${LocaleKeys.date_assert.tr()} : ',
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 6.0, left: 18),
                        child: Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                      snapshot.data?.docs[index]['arrest_date'])
                                  .format() ??
                              'نامشخص',
                          style: context.textTheme.titleLarge?.copyWith(
                            fontFamily: Fonts.yekanBakhFaNum,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${LocaleKeys.date_freedom.tr()} : ',
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0, left: 18),
                      child: Text(
                        snapshot.data?.docs[index]['freedom_date'] != null
                            ? DateTime.fromMillisecondsSinceEpoch(snapshot
                                        .data?.docs[index]['freedom_date'])
                                    .format() ??
                                'نامشخص'
                            : 'نامشخص',
                        style: context.textTheme.titleLarge?.copyWith(
                          fontFamily: Fonts.yekanBakhFaNum,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          if (context
              .read<GalleryBloc>()
              .grouping!
              .contains(GroupType.deceased.intGroupType()))
            Padding(
              padding: const EdgeInsets.only(right: 22.0),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    '${LocaleKeys.date_death.tr()} : ',
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0, left: 18),
                    child: Text(
                      DateTime.fromMillisecondsSinceEpoch(
                                  snapshot.data?.docs[index]['death_date'])
                              .format() ??
                          'نامشخص',
                      style: context.textTheme.titleLarge?.copyWith(
                        fontFamily: Fonts.yekanBakhFaNum,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(
            height: 8,
          ),

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
