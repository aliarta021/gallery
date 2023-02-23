import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:revolution1401/modules/gallery/ui/pages/gallery_page.dart';
import 'package:revolution1401/modules/main/bloc/main_page_bloc.dart';
import 'package:revolution1401/modules/main/ui/pages/inital_page.dart';
import 'package:revolution1401/modules/main/ui/pages/main_page.dart';

class R {
  static const String main = '/';

  static const String home = '/home';

  static const String initialPage = '/initial-page';

  static const String galleryPage = '/gallery-page';
}

class AppRouter {
  late final GoRouter router = GoRouter(
    redirect: (context, state) async {
      if ((await context.read<MainPageBloc>().checkSeenFirstPage())) {
        return R.initialPage;
      } else {
        return null;
      }
    },
    debugLogDiagnostics: true,
    observers: <NavigatorObserver>[BotToastNavigatorObserver()],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      restorationId: state.pageKey.value,
      child: Container(),
    ),
    routes: <GoRoute>[
      _route(path: R.main, pageBuilder: (state) => const MainPage()),
      _route(path: R.initialPage, pageBuilder: (state) => const InitialPage()),
      _route(path: R.galleryPage, pageBuilder: (state) => const GalleryPage()),
    ],
  );

  GoRoute _route(
          {required String path,
          required Widget Function(GoRouterState state) pageBuilder,
          List<GoRoute> routes = const []}) =>
      GoRoute(
        path: path,
        routes: routes,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            CupertinoPage<void>(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: pageBuilder(state),
        ),
      );
}
