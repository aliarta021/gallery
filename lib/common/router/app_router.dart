import 'dart:io';
import 'dart:js';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:revolution1401/modules/main/bloc/main_bloc.dart';
import 'package:revolution1401/modules/main/ui/pages/inital_page.dart';

class R {
  static const String main = '/';

  static const String home = '/home';

  static const String initialPage = '/initial_page';

  static const String completeInformation = '/complete-information';

  static const _item = '/item/:id';

  static String item({required String id}) => _item.replaceFirst(':id', id);

  static const _shop = '/shop/:id';

  static String shop({required String id}) =>
      _shop.replaceFirst(':id', id.toString());

  static const _addShopComment = 'add-comment';

  static String addShopComment({required String shopId}) =>
      '${shop(id: shopId)}/$_addShopComment';

  static const String club = '/club';

  static const String shopList = '/shop-list';

  static const String accountInformation = '/account-information';

  static const String userComments = '/comments';

  static const _staticPage = '/static-page/:slug';

  static String staticPage({required String slug}) =>
      _staticPage.replaceFirst(':slug', slug);

  static const String cart = '/cart';
}

class AppRouter {
  late final GoRouter router = GoRouter(
    redirect: (context, state) async {
      if ((await context.read<MainBloc>().checkSeenFirstPage())) {
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
      _route(path: R.initialPage, pageBuilder: (state) => const InitialPage()),
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
