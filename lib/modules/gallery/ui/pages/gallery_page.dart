import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';
import 'package:revolution1401/common/utils/status_bar.dart';
import 'package:revolution1401/modules/gallery/bloc/gallery_bloc.dart';
import 'package:revolution1401/modules/gallery/ui/pages/image_view_page.dart';
import 'package:revolution1401/modules/gallery/ui/widgets/gallery_header_widget.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GalleryBloc(),
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: StatusBar.page(context),
          child: Scaffold(
            backgroundColor: context.colors.background,
            body: SizedBox.expand(
              child: Stack(
                children: [
                  const GalletyHeaderWidget(),
                  DraggableScrollableSheet(
                    initialChildSize: 0.78,
                    minChildSize: 0.78,
                    snap: true,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        margin: const EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                          color: context.colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: Consumer<GalleryBloc>(
                            builder: (context, bloc, child) {
                          return GridView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount: bloc.imageList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  print(index);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImageViewPage(
                                        image: bloc.imageList[index],
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    bloc.imageList[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            gridDelegate: SliverQuiltedGridDelegate(
                              crossAxisCount: 4,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              repeatPattern: QuiltedGridRepeatPattern.inverted,
                              pattern: const [
                                QuiltedGridTile(2, 2),
                                QuiltedGridTile(1, 1),
                                QuiltedGridTile(1, 1),
                                QuiltedGridTile(1, 1),
                                QuiltedGridTile(1, 1),
                              ],
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
