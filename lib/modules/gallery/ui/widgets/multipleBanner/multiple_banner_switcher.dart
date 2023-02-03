import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette.dart';
import 'package:revolution1401/common/uikit/cin_image.dart';
import 'package:revolution1401/common/uikit/clickable/push_down_clickable.dart';
import 'package:revolution1401/modules/home/models/banner_model.dart';
import 'package:separated_row/separated_row.dart';

class MultipleBannerSwitcher extends StatefulWidget {
  MultipleBannerSwitcher(
      {required this.items,
      required this.selected,
      required this.controller,
      this.tileSize = 50,
      this.spaceSize = 4.5,
      this.tileRadius,
      this.parentRadius,
      this.duration = const Duration(milliseconds: 250),
      this.onChanged,
      this.curve = Curves.linear,
      Key? key})
      : super(key: key);

  final double tileSize;
  final double spaceSize;
  final BorderRadius? tileRadius;
  final BorderRadius? parentRadius;
  final List<String> items;
  final Duration duration;
  final ValueChanged<String>? onChanged;
  int selected;
  final CarouselController controller;
  final Curve curve;

  @override
  State<MultipleBannerSwitcher> createState() => _MultipleBannerSwitcherState();
}

class _MultipleBannerSwitcherState extends State<MultipleBannerSwitcher> {
  late final BorderRadius _tileRadius;
  late final BorderRadius _parentRadius;

  @override
  void initState() {
    _tileRadius = widget.tileRadius ?? BorderRadius.circular(12);
    _parentRadius = widget.tileRadius ?? BorderRadius.circular(16);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Builder(builder: (context) {
        final double width = (widget.tileSize * widget.items.length) +
            (widget.spaceSize * (widget.items.length + 3));
        final double selectedTileSize =
            widget.tileSize + (widget.spaceSize * 2);
        final double selectedTileBackgroundSize =
            widget.tileSize + (widget.spaceSize * 4);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
              height: selectedTileBackgroundSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: width,
                    height: selectedTileSize,
                    decoration: BoxDecoration(
                      color: ColorPalette.of(context).scaffoldBackground,
                      borderRadius: _parentRadius,
                      boxShadow: [
                        BoxShadow(
                          color:
                              ColorPalette.of(context).shadow.withOpacity(0.18),
                          offset: const Offset(0, 4),
                          blurRadius: 7,
                        ),
                      ],
                    ),
                  ),
                  AnimatedPositionedDirectional(
                    curve: widget.curve,
                    start:
                        widget.selected * (widget.tileSize + widget.spaceSize),
                    duration: widget.duration,
                    child: Container(
                      width: selectedTileBackgroundSize,
                      height: selectedTileBackgroundSize,
                      decoration: BoxDecoration(
                        borderRadius: _parentRadius,
                        color: ColorPalette.of(context).scaffoldBackground,
                        boxShadow: [
                          BoxShadow(
                            color: ColorPalette.of(context)
                                .shadow
                                .withOpacity(0.05),
                            offset: const Offset(0, 6),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IntrinsicHeight(
                      child: SeparatedRow(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.items
                            .map((e) => PushDownClickable(
                                  onTap: () {
                                    setState(() {
                                      widget.selected = widget.items.indexOf(e);
                                    });
                                    widget.controller.animateToPage(
                                        widget.items.indexOf(e),
                                        duration: widget.duration,
                                        curve: widget.curve);
                                    if (widget.onChanged != null) {
                                      widget.onChanged!(e);
                                    }
                                  },
                                  child: ClipRRect(
                                    borderRadius: _tileRadius,
                                    child: AnimatedContainer(
                                      duration: widget.duration,
                                      width: widget.selected ==
                                              widget.items.indexOf(e)
                                          ? selectedTileSize
                                          : widget.tileSize,
                                      height: widget.selected ==
                                              widget.items.indexOf(e)
                                          ? selectedTileSize
                                          : widget.tileSize,
                                      child: AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: Image.asset(e),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: widget.spaceSize),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      });
}
