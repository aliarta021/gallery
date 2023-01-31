import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revolution1401/common/localization/locale_keys.g.dart';
import 'package:revolution1401/common/styles/appTheme/app_theme_helper.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';
import 'package:revolution1401/modules/gallery/bloc/gallery_bloc.dart';
import 'package:revolution1401/modules/gallery/ui/widgets/search_bar_widget.dart';

class GalletyHeaderWidget extends StatefulWidget {
  const GalletyHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GalletyHeaderWidget> createState() => _GalletyHeaderWidgetState();
}

class _GalletyHeaderWidgetState extends State<GalletyHeaderWidget> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  LocaleKeys.gallery_discover.tr(),
                  style: context.textTheme.bodyLarge?.copyWith(fontSize: 20),
                ),
              ),
              Expanded(
                flex: 2,
                child: SearchBarAnimation(
                    // searchBoxWidth: 250,
                    buttonBorderColour: Colors.transparent,
                    // buttonColour: Colors.transparent,
                    enableBoxBorder: false,
                    enableButtonBorder: false,
                    textEditingController: TextEditingController(),
                    isOriginalAnimation: true,
                    trailingWidget: const Icon(Icons.search),
                    secondaryButtonWidget: const Icon(Icons.close),
                    buttonWidget: Icon(
                      Icons.search,
                      color: context.colors.black.withOpacity(0.8),
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                children: [
                  CircleAvatar(
                    maxRadius: 25,
                    backgroundImage: ExactAssetImage(
                        context.read<GalleryBloc>().imageList[index]),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text('data')
                ],
              ),
            ),
            itemCount: 8,
          ),
        ),
      ],
    );
  }
}
