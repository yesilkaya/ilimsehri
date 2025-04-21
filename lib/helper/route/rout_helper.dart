import 'package:flutter/material.dart';
import 'package:ilimsehri/view/screens/dua_munacat.dart';
import 'package:ilimsehri/view/screens/ehlibeyt/ehlibeyt_screen.dart';
import 'package:ilimsehri/view/screens/eyyamullah/eyyamullah_screen.dart';
import 'package:ilimsehri/view/screens/fatima_alidir_screen.dart';
import 'package:ilimsehri/view/screens/tefsir/tefsir_list_screen.dart';

import '../../constant/route_constants.dart';
import '../../view/screens/aylarin_amelleri/aylarin_amelleri.dart';
import '../../view/screens/book_detail_screen.dart';
import '../../view/screens/child_books_screen.dart';
import '../../view/screens/fikih/fikih_screen.dart';
import '../../view/screens/gaybin_dili_screen.dart';
import '../../view/screens/home_screen.dart';
import '../../view/screens/kuran/sureler_list_screen.dart';
import '../../view/screens/ramazan/ramazan_screen.dart';
import '../../view/screens/settings_screen.dart';
import '../../view/screens/splash/splash_screen.dart';
import '../../view/screens/zikir/zikir_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );

    case homeScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

    case kuranScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SurelerListScreen(),
      );

    case fikihScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const FikihScreen(),
      );

    case duaMunaacatScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const DuaMunacatScreen(),
      );

    case zikirScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const ZikirScreen(),
      );

    case cocukScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const ChildBooksScreen(),
      );

    case gaybScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const GaybinDiliScreen(),
      );
    case ramazanScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const RamazanScreen(),
      );

    case ehlibeytScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const EhlibeytScreen(),
      );

    case tefsirScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const TefsirListScreen(),
      );

    case aylarinAmelleriScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const AylarinAmelleri(),
      );

    case fatimaAlidirScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const FatimaAlidirScreen(),
      );

    case eyyamullahScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const EyyamullahScreen(),
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
        builder: (context) => const SplashScreen(),
      );
  }
}
