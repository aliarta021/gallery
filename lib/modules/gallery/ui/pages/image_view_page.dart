import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_view/photo_view.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';

class ImageViewPage extends StatelessWidget {
  const ImageViewPage({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          PhotoView(
            imageProvider: AssetImage(image),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: context.colors.error,
            ),
          ),
        ],
      ),
    );
  }
}
