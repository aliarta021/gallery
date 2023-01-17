import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:revolution1401/common/uikit/search_widget.dart';
import 'package:revolution1401/common/utils/status_bar.dart';
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
                
              ],
            ),
          ),
        ),
      );
}
