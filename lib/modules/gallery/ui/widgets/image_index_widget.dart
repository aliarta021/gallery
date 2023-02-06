import 'package:flutter/material.dart';
import 'package:revolution1401/modules/gallery/bloc/gallery_bloc.dart';
import 'package:revolution1401/modules/gallery/ui/pages/image_view_page.dart';

class ImageIndexWidget extends StatelessWidget {
  const ImageIndexWidget({
    super.key,
    required this.index,
    required this.bloc,
  });

  final int index;
  final GalleryBloc bloc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        print(index);
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageViewPage(
              image: bloc.imageList[index],
              controller: PageController(),
              items: bloc.imageList,
              selectedImage: index,
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          bloc.imageList[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
