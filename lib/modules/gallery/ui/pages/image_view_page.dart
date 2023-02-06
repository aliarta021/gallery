import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';
import 'package:revolution1401/common/uikit/clickable/push_down_clickable.dart';

class ImageViewPage extends StatefulWidget {
  ImageViewPage({
    super.key,
    required this.controller,
    required this.image,
    required this.items,
    required this.selectedImage,
    this.tileSize = 30,
    this.spaceSize = 2,
  });
  final List<String> items;
  final double tileSize;
  final double spaceSize;
  int selectedImage;
  PageController controller;

  String image;

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  @override
  void initState() {
    widget.controller = PageController(initialPage: widget.selectedImage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = 30;
    final double selectedTileSize = 40;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          PhotoViewGallery.builder(
            pageController: widget.controller,
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(widget.items[widget.selectedImage]),
                initialScale: PhotoViewComputedScale.contained,
                heroAttributes: PhotoViewHeroAttributes(
                    tag: widget.items[widget.selectedImage]),
              );
            },
            backgroundDecoration:
                BoxDecoration(color: context.colors.scaffoldBackground),
            itemCount: widget.items.length,
            loadingBuilder: (context, event) => Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded /
                          (event.expectedTotalBytes ?? 0),
                ),
              ),
            ),
            onPageChanged: (value) {
              setState(() {
                widget.selectedImage = value;
              });
            },
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.items.length,
                  itemBuilder: (BuildContext context, index) =>
                      PushDownClickable(
                    onTap: () {
                      setState(() {
                        widget.selectedImage =
                            widget.items.indexOf(widget.items[index]);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: widget.selectedImage ==
                                  widget.items.indexOf(widget.items[index])
                              ? selectedTileSize
                              : widget.tileSize,
                          height: widget.selectedImage ==
                                  widget.items.indexOf(widget.items[index])
                              ? selectedTileSize
                              : widget.tileSize,
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
