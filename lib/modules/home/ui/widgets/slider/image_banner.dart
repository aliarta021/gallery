import 'package:flutter/material.dart';
import 'package:revolution1401/common/uikit/clickable/fade_clickable.dart';
import 'package:revolution1401/modules/home/models/banner_model.dart';

class ImageBanner extends StatelessWidget {
  const ImageBanner(this.banneer,{
    this.borderRadius = 10,
    Key? key,
  }) : super(key: key);

  final BannerModel? banneer;
  final double borderRadius;

  @override
  Widget build(BuildContext context) => FadeClickable(
        onTap: () {
          print(banneer?.name);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image(
            image: AssetImage(banneer?.image?.mobile?.fa?.hashKey ?? ''),
            fit: BoxFit.fitHeight,
          ),
        ),
      );
}
