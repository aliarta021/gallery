import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:revolution1401/modules/home/models/slider_model.dart';
import 'package:revolution1401/modules/home/ui/widgets/slider/image_banner.dart';

class SimpleBannerSlider extends StatelessWidget {
  const SimpleBannerSlider(this.slider, {Key? key}) : super(key: key);

  final SliderModel slider;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              enableInfiniteScroll: slider.infiniteScroll ?? (slider.items?.length ?? 0) > 1,
              autoPlay: slider.autoPlay ?? (slider.items?.length ?? 0) > 1,
              // TODO(hossein): check this
              // scrollPhysics: (slider.items?.length ?? 0) > 1
              //     ? const BouncingScrollPhysics()
              //     : const NeverScrollableScrollPhysics(),
              autoPlayAnimationDuration: const Duration(milliseconds: 1200),
              viewportFraction: 0.7,
              aspectRatio: 1.4286,
              enlargeCenterPage: true,
            ),
            itemCount: slider.items?.length ?? 0,
            itemBuilder: (BuildContext context, int index, int realIndex) => ImageBanner(
              imagePath: slider.items![index],
            ),
          ),
        ],
      );
}
