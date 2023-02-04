import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:revolution1401/common/resources/resources.dart';
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
  CarouselController controller;

  String image;

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

List image = [1, 2, 3, 4];

class _ImageViewPageState extends State<ImageViewPage> {
  // @override
  // void initState() {
  //   widget.controller = PhotoViewController();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final double width = (widget.tileSize * widget.items.length) +
        (widget.spaceSize * (widget.items.length + 3));
    final double selectedTileSize = widget.tileSize + (widget.spaceSize * 2);
    final double selectedTileBackgroundSize =
        widget.tileSize + (widget.spaceSize * 4);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
              child: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: AssetImage(widget.items[index]),
                initialScale: PhotoViewComputedScale.contained * 0.8,
                heroAttributes:
                    PhotoViewHeroAttributes(tag: widget.items[index]),
              );
            },
            itemCount: widget.items.length,
            loadingBuilder: (context, event) => Center(
              child: Container(
                width: 20.0,
                height: 20.0,
                // child: CircularProgressIndicator(
                //   value: event == null
                //       ? 0
                //       : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                // ),
              ),
            ),
            // backgroundDecoration: widget.backgroundDecoration,
            // pageController: widget.pageController,
            onPageChanged: (value) {
              widget.selectedImage = value;
            },
          )),
          // PhotoView(
          //   imageProvider: AssetImage(widget.image),
          //   backgroundDecoration:
          //       const BoxDecoration(color: Colors.transparent),
          //   controller: PhotoViewController(),
          // ),
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
                height: widget.selectedImage == 0 ? 60 : 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: ScrollController(),
                  itemCount: widget.items.length,
                  itemBuilder: (BuildContext context, index) => SizedBox(
                    height: 40,
                    child: PushDownClickable(
                      onTap: () {
                        print(index);
                        setState(() {
                          widget.selectedImage =
                              widget.items.indexOf(widget.items[index]);
                          widget.image = widget.items[index];
                        });
                        // widget.controller.animateToPage(
                        //     widget.items.indexOf(widget.items[index]),
                        //     duration: const Duration(microseconds: 200),
                        //     curve: Curves.easeInOut);
                        // if (widget.onChanged != null) {
                        //   widget.onChanged!(e);
                        // }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: AnimatedContainer(
                            // width: 30,
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
