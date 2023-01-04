import 'package:flutter/cupertino.dart';
import 'package:revolution1401/modules/main/ui/pages/inital_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBloc extends ChangeNotifier {
  Future checkSeenFirstPage() async {
    final prefs = await SharedPreferences.getInstance();
    bool seenPage = prefs.getBool('seen') ?? false;
    return seenPage;
  }
}
