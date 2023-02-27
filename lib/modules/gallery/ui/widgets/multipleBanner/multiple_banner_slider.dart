import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette.dart';
import 'package:revolution1401/common/uikit/switcher.dart';
import 'package:revolution1401/common/uikit/text/title_widget.dart';
import 'package:revolution1401/modules/gallery/ui/widgets/multipleBanner/multiple_banner_tile.dart';
import 'package:revolution1401/modules/home/models/banner_model.dart';


class MultipleBannerSlider extends StatefulWidget {
  const MultipleBannerSlider(this.slider,
      {this.autoPlayDuration = const Duration(seconds: 5),
      this.animationDuration = const Duration(milliseconds: 250),
      this.animationCurve = Curves.easeInOut,
      Key? key})
      : super(key: key);

  final List<BannerModel> slider;
  final Duration autoPlayDuration;
  final Duration animationDuration;
  final Curve animationCurve;

  @override
  State<MultipleBannerSlider> createState() => _MultipleBannerSliderState();
}

class _MultipleBannerSliderState extends State<MultipleBannerSlider> {
  int selectedBanner = 0;
  CarouselController controller = CarouselController();
  Timer? _changePageDelayTimer;

  @override
  void dispose() {
    _changePageDelayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            TitleWidget.fromSlider(
              widget.slider[0],
              padding: const EdgeInsets.only(bottom: 15),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CarouselSlider.builder(
                      carouselController: controller,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll:  true,//widget.slider.infiniteScroll ?? (widget.slider.items?.length ?? 0) > 1,
                        autoPlay: true, //widget.slider.autoPlay ?? (widget.slider.items?.length ?? 0) > 1,
                        // TODO(hossein): check this
                        // scrollPhysics: (widget.slider.items?.length ?? 0) > 1
                        //     ? const BouncingScrollPhysics()
                        //     : const NeverScrollableScrollPhysics(),
                        autoPlayAnimationDuration: const Duration(milliseconds: 1200),
                        autoPlayInterval: widget.autoPlayDuration,
                        viewportFraction: 1,
                        aspectRatio: 4 / 3,
                        onPageChanged: (int index, CarouselPageChangedReason reason) {
                          if (reason == CarouselPageChangedReason.controller) {
                            _changePageDelayTimer?.cancel();
                            _changePageDelayTimer = Timer(
                                Duration(
                                    milliseconds: widget.animationDuration.inMilliseconds <= 200
                                        ? 200
                                        : widget.animationDuration.inMilliseconds), () {
                              _changeSelectedIndex(index);
                            });
                          } else {
                            _changeSelectedIndex(index);
                          }
                        },
                      ),
                      itemCount: widget.slider.length,
                      itemBuilder: (BuildContext context, int index, int i) => ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: MultipleBannerTile(
                          widget.slider[index],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Builder(builder: (context) {
                      String title = (widget.slider[selectedBanner].name ?? '').trim();
                      return Switcher(
                        child: title.isEmpty
                            ? const SizedBox.shrink(key: Key('shrink'))
                            : LayoutBuilder(
                                builder: (context, size) => GlassContainer.clearGlass(
                                      key: const Key('glassContainer'),
                                      width: size.maxWidth / 1.8,
                                      height: 60,
                                      margin: const EdgeInsets.only(top: 20),
                                      borderRadius: BorderRadius.circular(15),
                                      borderColor: Colors.white.withOpacity(0.1),
                                      blur: 12,
                                      gradient: LinearGradient(
                                        colors: [Colors.white.withOpacity(0.3), Colors.white.withOpacity(0.0)],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        stops: const [0, 0.65],
                                      ),
                                      borderGradient: LinearGradient(
                                        colors: [
                                          Colors.white.withOpacity(0.1),
                                          Colors.white.withOpacity(0.01),
                                          Colors.white.withOpacity(0.0),
                                          Colors.white.withOpacity(0.08)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        stops: const [0.0, 0.39, 0.40, 1.0],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Switcher(
                                          switchInCurve: const Interval(0.6, 1.0),
                                          switchOutCurve: const Interval(0.6, 1.0),
                                          child: Text(
                                            title,
                                            key: Key(title),
                                            style: Theme.of(context).textTheme.headline6!.copyWith(
                                              fontSize: 18,
                                              color: ColorPalette.of(context).white,
                                              fontWeight: FontWeight.w900,
                                              shadows: [
                                                Shadow(
                                                  color: ColorPalette.of(context).shadow.withOpacity(0.7),
                                                  offset: const Offset(0, 1),
                                                  blurRadius: 8,
                                                )
                                              ],
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    )),
                      );
                    }),
                  ),
                ),
                // MultipleBannerSwitcher(
                //   controller: controller,
                //   duration: widget.animationDuration,
                //   curve: widget.animationCurve,
                //   items: widget.slider ?? [],
                //   selected: selectedBanner,
                //   onChanged: (banner) {
                //     setState(() {
                //       selectedBanner = widget.slider.indexOf(banner);
                //     });
                //   },
                // ),
              ],
            ),
          ],
        ),
      );

  void _changeSelectedIndex(int index) {
    setState(() {
      if (index != selectedBanner) {
        selectedBanner = index;
      }
    });
  }
}
