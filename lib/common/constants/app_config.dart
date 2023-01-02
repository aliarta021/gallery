import 'dart:ui';

class AppConfig {
  static const String name = 'Revolution1401';
  static const bool debug = true;
  // static const String sentryDns = 'https://cd0349e12f144f09bed5dfa98f1ce826@sentry.mobit.ir/17';

  static const String localePath = 'resources/langs';
  static const List<Locale> supportedLocales = <Locale>[
    Locale('fa', 'IR'),
    Locale('en', 'US'),
    // Locale('ar', 'AE'),
  ];
  static const Locale startLocale = Locale('fa', 'IR');

  // static const String baseUrl = 'https://api.dev.paybuy.ir/';
  // static const String apiBaseUrl = '${baseUrl}api/v1/';
  // static const String privacyPolicyUrl = 'https://www.mobit.ir/page/privacy-policy';
  // static const String clientId = 'Y7zoEL7kZxsi92epGHFRzg3uG6pTQnRm';
  static const String version = '1.0.0';
  static const String buildNumber = '1.0.0';
}
