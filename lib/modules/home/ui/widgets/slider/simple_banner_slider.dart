import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:revolution1401/modules/home/models/banner_model.dart';
import 'package:revolution1401/modules/home/ui/widgets/slider/image_banner.dart';

class SimpleBannerSlider extends StatelessWidget {
  const SimpleBannerSlider(this.slider, {Key? key}) : super(key: key);

  final List<BannerModel> slider;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              enableInfiniteScroll: true,
              autoPlay:
                  slider.length > 1 /* ?? (slider.items?.length ?? 0) > 1 */,
              // scrollPhysics: (slider.items?.length ?? 0) > 1
              //     ? const BouncingScrollPhysics()
              //     : const NeverScrollableScrollPhysics(),
              autoPlayAnimationDuration: const Duration(milliseconds: 1200),
              onPageChanged: (index, reason) => {},
              viewportFraction: 0.7,
              aspectRatio: 1.4286,
              enlargeCenterPage: true,
            ),
            itemCount: slider.length,
            itemBuilder: (BuildContext context, int index, int realIndex) =>
                ImageBanner(
              slider[index],
            ),
          ),
        ],
      );
}
