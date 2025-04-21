import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/color_styles.dart';
import '../../helper/notify_helper.dart';
import '../../helper/platform_helper.dart';
import '../../widgets/carousel_slider_widget.dart';
import '../../widgets/categories.dart';
import '../../widgets/salah_time.dart';
import 'drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final InAppReview _inAppReview = InAppReview.instance;
  late SharedPreferences prefs;

  @override
  void initState() {
    if (PlatformHelper.isIos) getAllNotifications();
    _checkAndRequestReview();
    super.initState();
  }

  Future<void> _checkAndRequestReview() async {
    prefs = await SharedPreferences.getInstance();
    bool hasReviewed = prefs.getBool('hasReviewed') ?? false;

    if (hasReviewed == false) {
      await Future.delayed(const Duration(seconds: 3));
      await _requestReview();
      await prefs.setBool('hasReviewed', true); // İşaretle, bir daha açılmasın
    }
  }

  Future<void> _requestReview() => _inAppReview.requestReview();

  Future<void> getAllNotifications() async {
    await LocalNotificationService.getScheduledNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: DrawerScreen(), // Drawer
      backgroundColor: ColorStyles.appBackGroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSliderWidget(),
              SalahTime(),
              Categories(),
            ],
          ),
        ),
      ),
    );
  }
}
