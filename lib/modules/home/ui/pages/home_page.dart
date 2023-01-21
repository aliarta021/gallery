import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:revolution1401/common/uikit/search_widget.dart';
import 'package:revolution1401/common/utils/status_bar.dart';
import 'package:revolution1401/modules/home/bloc/home_bloc.dart';
import 'package:revolution1401/modules/home/ui/widgets/slider/simple_banner_slider.dart';
import 'package:revolution1401/modules/main/ui/widgets/header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: StatusBar.page(context),
        child: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                HeaderSliverWidget(
                  searchWidget: SearchWidget(
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 30),
                        child: SimpleBannerSlider(context.read<HomeBloc>().list),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
