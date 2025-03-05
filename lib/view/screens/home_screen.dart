import 'package:flutter/material.dart';

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
  @override
  void initState() {
    if (PlatformHelper.isIos) getAllNotifications();
    super.initState();
  }

  Future<void> getAllNotifications() async {
    await LocalNotificationService.cancelAllNotifications();
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
