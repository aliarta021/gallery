import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBloc extends ChangeNotifier {
  Future checkSeenFirstPage() async {
    final prefs = await SharedPreferences.getInstance();
    bool seenPage = prefs.getBool('seen') ?? false;
    return seenPage;
  }
}
