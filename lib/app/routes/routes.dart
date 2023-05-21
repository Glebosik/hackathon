import 'package:flutter/widgets.dart';
import 'package:hackathon/app/app.dart';
import 'package:hackathon/auth/auth_page.dart';
import 'package:hackathon/home/home.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [AuthPage.page()];
  }
}
