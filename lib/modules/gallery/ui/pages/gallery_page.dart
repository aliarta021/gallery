import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:revolution1401/common/localization/locale_keys.g.dart';
import 'package:revolution1401/common/styles/appTheme/app_theme_helper.dart';
import 'package:revolution1401/common/utils/status_bar.dart';
import 'package:revolution1401/modules/gallery/ui/widgets/gallery_header_widget.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: StatusBar.page(context),
        child: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                GalletyHeaderWidget(),
                // SliverAnimatedList(
                //   initialItemCount: 5,
                //   itemBuilder: (context, index, animation) => Container(
                //     width: 10,
                //     height: 10,
                //     margin: const EdgeInsets.all(8),
                //     color: Colors.amber,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      );
}

