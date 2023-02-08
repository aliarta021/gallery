import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:revolution1401/common/constants/app_config.dart';
import 'package:revolution1401/common/localization/locale_keys.g.dart';
import 'package:revolution1401/common/router/app_router.dart';
import 'package:revolution1401/common/styles/appTheme/app_theme.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette.dart';
import 'package:revolution1401/common/uikit/clickable/push_down_clickable.dart';
import 'package:revolution1401/common/utils/app_scroll_behavior.dart';
import 'package:revolution1401/modules/home/bloc/home_bloc.dart';
import 'package:revolution1401/modules/main/bloc/main_page_bloc.dart';
import 'package:revolution1401/modules/main/ui/pages/splash_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<AppRouter>(
            lazy: false,
            create: (BuildContext createContext) => AppRouter(),
          ),
          ChangeNotifierProvider(
              create: (BuildContext context) => MainPageBloc()),
          ChangeNotifierProvider(create: (BuildContext context) => HomeBloc()),
        ],
        child: EasyLocalization(
          supportedLocales: AppConfig.supportedLocales,
          path: AppConfig.localePath,
          startLocale: AppConfig.startLocale,
          fallbackLocale: AppConfig.startLocale,
          useOnlyLangCode: true,
          child: RefreshConfiguration(
            headerBuilder: () => const MaterialClassicHeader(),
            footerBuilder: () => CustomFooter(
              builder: (BuildContext context, LoadStatus? mode) {
                if (mode == LoadStatus.loading) {
                  return SizedBox(
                    height: 65,
                    child: Center(
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: ColorPalette.of(context).primary)),
                    ),
                  );
                } else if (mode == LoadStatus.failed) {
                  return SizedBox(
                    height: 55,
                    child: Center(
                      child: Text(
                        LocaleKeys.err_tryAgain.tr(),
                        style: Theme.of(context).textTheme.overline!.copyWith(
                              color: ColorPalette.of(context).textCaption,
                            ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            child: Builder(
              builder: (BuildContext context) => MaterialApp.router(
                title: AppConfig.name,
                theme: AppTheme.light,
                scrollBehavior: const AppScrollBehavior(),
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                builder: (BuildContext context, Widget? child) =>
                    BotToastInit()(
                        context,
                        FutureBuilder(
                          future: Firebase.initializeApp(),
                          builder: (context, snapshot) => snapshot.hasData
                              ? (child ?? const SizedBox.shrink())
                              : SplashPage(
                                  child: snapshot.hasError
                                      ? PushDownClickable(
                                          onTap: () {
                                            Phoenix.rebirth(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(25),
                                            child: Icon(
                                              Icons.refresh_rounded,
                                              color: ColorPalette
                                                  .light.textCaption,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                        )),
                routeInformationParser:
                    context.read<AppRouter>().router.routeInformationParser,
                routerDelegate: context.read<AppRouter>().router.routerDelegate,
                debugShowCheckedModeBanner: false,
              ),
            ),
          ),
        ),
      );
}
