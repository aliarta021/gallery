import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette.dart';
import 'package:revolution1401/modules/main/bloc/main_page_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (context, constraints) => Scaffold(
            body: Consumer<MainPageBloc>(
              builder: (BuildContext context, MainPageBloc bloc, Widget? child) => bloc.page,
            ),
            bottomNavigationBar:
                Consumer<MainPageBloc>(builder: (BuildContext context, MainPageBloc bloc, Widget? child) {
              Color unselectedColor = Theme.of(context).disabledColor;
              Color selectedColor = Theme.of(context).primaryColor;
              return Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: ColorPalette.of(context).shadow, blurRadius: 5),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    BottomNavigationBar(
                      currentIndex: bloc.pageIndex,
                      onTap: (int index) {
                        bloc.changePage(context, index);
                      },
                      selectedLabelStyle:
                          Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w800),
                      unselectedLabelStyle: Theme.of(context).textTheme.overline?.copyWith(fontSize: 10),
                      selectedItemColor: selectedColor,
                      unselectedItemColor: unselectedColor,
                      showUnselectedLabels: false,
                      type: BottomNavigationBarType.fixed,
                      elevation: 0,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      items: List<BottomNavigationBarItem>.generate(
                          MainPages.values.length,
                          (index) => _navigationBarItem(
                              bloc: bloc,
                              title: MainPages.values[index].titleKey.tr(),
                              icon: MainPages.values[index].icon,
                              index: index)),
                    ),
                    AnimatedPositionedDirectional(
                        curve: Curves.easeInOut,
                        start: bloc.pageIndex * (constraints.maxWidth / bloc.pagesCount),
                        duration: const Duration(milliseconds: 230),
                        child: Container(
                          width: constraints.maxWidth / bloc.pagesCount,
                          height: 2,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: ColorPalette.of(context).primary,
                          ),
                        )),
                  ],
                ),
              );
            }),
          ));

  BottomNavigationBarItem _navigationBarItem(
          {required MainPageBloc bloc, required String title, required int index, String? asset, IconData? icon}) =>
      BottomNavigationBarItem(
        label: title,
        icon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: bloc.pageIndex == index ? 27 : 30,
            height: bloc.pageIndex == index ? 25 : 30,
            child: icon != null
                ? FittedBox(
                    child: Icon(icon),
                  )
                : Padding(
                    padding: const EdgeInsets.all(2),
                    child: SvgPicture.asset(
                      asset!,
                    ),
                  ),
          ),
        ),
      );
}
