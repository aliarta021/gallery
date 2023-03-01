import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revolution1401/common/router/app_router.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';
import 'package:revolution1401/modules/gallery/bloc/gallery_bloc.dart';
import 'package:revolution1401/modules/gallery/ui/pages/image_description_view.dart';
import 'package:revolution1401/modules/gallery/ui/pages/image_view_page.dart';

class ImageIndexWidget extends StatelessWidget {
  const ImageIndexWidget({
    super.key,
    required this.index,
    required this.bloc,
    required this.snapshot,
  });

  final int index;
  final GalleryBloc bloc;
  final AsyncSnapshot<QuerySnapshot> snapshot;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        print(index);
      },
      onTap: () {
        // context.go(R.imageDescriptionView,extra: snapshot,);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDescrptionView(
              index: index,
              snapshot: snapshot,
              // image: bloc.imageList[index],
              // controller: PageController(),
              // items: bloc.imageList,
              // selectedImage: index,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: snapshot.data?.docs[index]['image_url'],
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
            padding: const EdgeInsets.all(18.0),
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
              color: context.colors.primary,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
