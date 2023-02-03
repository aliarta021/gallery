import 'dart:ui';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_view/photo_view.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';
import 'package:revolution1401/common/uikit/clickable/push_down_clickable.dart';
import 'package:revolution1401/modules/gallery/ui/widgets/multipleBanner/multiple_banner_switcher.dart';
import 'package:revolution1401/modules/home/models/banner_model.dart';

class ImageViewPage extends StatefulWidget {
  ImageViewPage(
      {super.key,
      required this.controller,
      required this.image,
      required this.items,
      required this.selectedImage});
  final List<String> items;
  int selectedImage;
  final CarouselController controller;

  final String image;

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          PhotoView(
            imageProvider: AssetImage(widget.image),
            backgroundDecoration: BoxDecoration(color: Colors.white),
            controller: PhotoViewController(),
          ),
          // IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: Icon(
          //     Icons.close,
          //     color: context.colors.error,
          //   ),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: ScrollController(),
                itemCount: widget.items.length,
                itemBuilder: (BuildContext context, index) => PushDownClickable(
                  onTap: () {
                    setState(() {
                      widget.selectedImage =
                          widget.items.indexOf(widget.items[index]);
                    });
                    widget.controller.animateToPage(widget.items.indexOf(widget.items[index]),
                        duration: Duration(microseconds: 200), curve: Curves.easeInOut);
                    // if (widget.onChanged != null) {
                    //   widget.onChanged!(e);
                    // }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: AnimatedContainer(
                      padding: const EdgeInsets.all(4),
                      duration: const Duration(milliseconds: 200),
                      // width: widget.selected == widget.items.indexOf(e)
                      //     ? selectedTileSize
                      //     : widget.tileSize,
                      // height: widget.selected == widget.items.indexOf(e)
                      //     ? selectedTileSize
                      //     : widget.tileSize,
                      child: Image.asset(
                        widget.items[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: MultipleBannerSwitcher(
          //     controller: CarouselController(),
          //     duration: Duration(milliseconds: 250),
          //     curve: Curves.easeInOut,
          //     items: widget.slider ?? [],
          //     selected: widget.selectedImage,
          //     onChanged: (banner) {
          //       setState(() {
          //         widget.selectedImage = widget.slider.indexOf(banner);
          //       });
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
