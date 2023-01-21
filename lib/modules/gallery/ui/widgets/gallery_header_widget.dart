import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revolution1401/common/localization/locale_keys.g.dart';
import 'package:revolution1401/common/styles/appTheme/app_theme_helper.dart';

class GalletyHeaderWidget extends StatefulWidget {
  const GalletyHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GalletyHeaderWidget> createState() => _GalletyHeaderWidgetState();
}

class _GalletyHeaderWidgetState extends State<GalletyHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 18.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.gallery_discover.tr(),
                  style: context.textTheme.headline6,
                ),
                IconButton(
                  icon: const Icon(Icons.search_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: CircleAvatar(
                  maxRadius: 25,
                ),
              ),
              itemCount: 8,
            ),
          ),
        ],
      ),
    );
  }
}
