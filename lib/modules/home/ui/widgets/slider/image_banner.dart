import 'package:flutter/material.dart';
import 'package:revolution1401/common/uikit/clickable/fade_clickable.dart';

class ImageBanner extends StatelessWidget {
  const ImageBanner( {
    required this.imagePath,
    this.borderRadius = 10,
    Key? key,
  }) : super(key: key);

  final String imagePath;
  final double borderRadius;

  @override
  Widget build(BuildContext context) => FadeClickable(
        onTap: (){},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image(
            image: AssetImage(imagePath),
            fit: BoxFit.fitHeight,
          ),
        ),
      );
}
