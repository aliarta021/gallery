import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revolution1401/common/localization/locale_keys.g.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette.dart';
import 'package:revolution1401/common/uikit/clickable/fade_clickable.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget(
      {Key? key,
      this.enabled = false,
      this.autofocus = false,
      this.controller,
      this.enableClearButton = false,
      this.onTap,
      this.onPressedClearButton,
      this.margin,
      this.hintText,
      this.onChanged,
      this.suffix})
      : super(key: key);
  final TextEditingController? controller;
  final bool enabled;
  final String? hintText;
  final GestureTapCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final bool enableClearButton;
  final bool autofocus;
  final void Function()? onPressedClearButton;
  void Function(String)? onChanged;
  final Widget? suffix;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) => Hero(
        tag: 'searchWidget',
        child: FadeClickable(
          onTap: widget.onTap,
          child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorPalette.of(context).background),
            margin: widget.margin ?? const EdgeInsets.only(right: 10, left: 10),
            width: double.infinity,
            height: kToolbarHeight - 12,
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: TextField(
                      onChanged: (text) {
                        if (_debounce?.isActive ?? false) {
                          _debounce?.cancel();
                        }
                        _debounce = Timer(const Duration(milliseconds: 500), () {
                          if (widget.onChanged != null) {
                            widget.onChanged!(text);
                          }
                        });
                      },
                      controller: widget.controller,
                      autofocus: widget.autofocus,
                      style: Theme.of(context).textTheme.subtitle2,
                      decoration: InputDecoration(
                        enabled: widget.enabled,
                        fillColor: Colors.transparent,
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.all(10),
                        hintText: widget.hintText ?? LocaleKeys.home_searchHint.tr(),
                        hintStyle:
                            Theme.of(context).textTheme.subtitle2!.copyWith(color: ColorPalette.of(context).hint),
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(Icons.search_rounded, color: ColorPalette.of(context).icon),
                            ),
                            const VerticalDivider(),
                            const SizedBox(width: 10),
                          ],
                        ),
                        suffixIcon: widget.enableClearButton
                            ? IconButton(
                                onPressed: widget.onPressedClearButton,
                                icon: Icon(Icons.close, color: ColorPalette.of(context).icon))
                            : null,
                      ),
                    ),
                  ),
                ),
                if (widget.suffix != null) widget.suffix!,
              ],
            ),
          ),
        ),
      );
}
