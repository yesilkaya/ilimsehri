import 'package:flutter/material.dart';

import '../../constant/route_constants.dart';
import '../../view/screens/book_detail_screen.dart';
import '../../view/screens/child_books_screen.dart';
import '../../view/screens/dua/dualar_screen.dart';
import '../../view/screens/eyyamullah/eyyamullah_screen.dart';
import '../../view/screens/gaybin_dili_screen.dart';
import '../../view/screens/home_screen.dart';
import '../../view/screens/kuran/sureler_list_screen.dart';
import '../../view/screens/munacat/munacatlar_screen.dart';
import '../../view/screens/sahife/sahifei_seccadiye_screen.dart';
import '../../view/screens/settings_screen.dart';
import '../../view/screens/splash/splash_screen.dart';
import '../../view/screens/zikir/zikir_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreenRoute:
      return MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );

    case homeScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

    case kuranScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SurelerListScreen(),
      );

    case sahifeiSeccadiyeScreenRoute:
      return MaterialPageRoute(
        builder: (context) => SahifeiSeccadiyeScreen(),
      );

    case duaScreenRoute:
      return MaterialPageRoute(
        builder: (context) => DualarScreen(),
      );

    case munacatScreenRoute:
      return MaterialPageRoute(
        builder: (context) => MunacatlarScreen(),
      );

    case zikirScreenRoute:
      return MaterialPageRoute(
        builder: (context) => ZikirScreen(),
      );

    case cocukScreenRoute:
      return MaterialPageRoute(
        builder: (context) => ChildBooksScreen(),
      );

    case gaybScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const GaybinDiliScreen(),
      );

    case eyyamullahScreenRoute:
      return MaterialPageRoute(
        builder: (context) => EyyamullahScreen(),
      );

    case settingsScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      );

    case bookDetailScreenRoute:
      final args = settings.arguments as Map<String, dynamic>?;
      final selectedBook = args?['selectedBook'];
      return MaterialPageRoute(
        builder: (context) => SelectedBookScreen(selectedBook: selectedBook),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => SplashScreen(),
      );
  }
}
