import 'package:flutter/widgets.dart';
import 'package:hackathon/app/app.dart';
import 'package:hackathon/auth/auth_page.dart';
import 'package:hackathon/home/home.dart';
import 'package:hackathon/home_inspector/view/home_inspector_splash.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticatedInspector:
      return [HomeInspectorSplash.page()];
    case AppStatus.authenticatedUser:
      return [HomeSplash.page()];
    case AppStatus.unauthenticated:
      return [AuthPage.page()];
  }
}
