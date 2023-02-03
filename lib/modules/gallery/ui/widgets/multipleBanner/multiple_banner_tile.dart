import 'package:flutter/material.dart';
import 'package:revolution1401/common/uikit/cin_image.dart';
import 'package:revolution1401/common/uikit/clickable/fade_clickable.dart';
import 'package:revolution1401/modules/home/models/banner_model.dart';

class MultipleBannerTile extends StatelessWidget {
  const MultipleBannerTile(this.banner, {Key? key}) : super(key: key);

  final BannerModel banner;

  @override
  Widget build(BuildContext context) => FadeClickable(
        onTap: () {}, // banner.clickAction?.toFunction(context),
        child: CinImage.fromHashKey(
          banner.image?.mobile?.tr()?.hashKey,
          key: Key(banner.image?.mobile?.tr()?.hashKey ?? ''),
        ),
      );
}
