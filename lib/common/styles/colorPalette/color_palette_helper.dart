import 'package:flutter/material.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette.dart';

extension ColorPaletteHelper on BuildContext {
  ColorPalette get colors => ColorPalette.of(this);
}
