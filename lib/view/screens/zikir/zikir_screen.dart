import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/constants.dart';

String imageName = 'meshed.jpeg';

class ZikirScreen extends StatefulWidget {
  const ZikirScreen({super.key});

  @override
  ZikirScreenState createState() => ZikirScreenState();
}

class ZikirScreenState extends State<ZikirScreen> {
  int counter = 0;
  bool isVibrationEnabled = false;
  bool _showIcons = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => _incrementCounter(),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/img/$imageName"), fit: BoxFit.fill),
              ),
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 6,
                  right: MediaQuery.of(context).size.width / 2,
                ),
                child: CircleAvatar(
                  radius: 52,
                  backgroundColor: Constants.cardColor,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,
                    child: Text(
                      '$counter',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: counter > 9999 ? 30 : 36,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height / 15,
              left: MediaQuery.of(context).size.width / 15,
              child: Container(
                height: 25,
                width: 55,
                color: Colors.transparent,
                alignment: Alignment.topLeft,
                child: InkWell(
                  child: const CircleAvatar(
                    backgroundColor: ColorStyles.appBackGroundColor,
                    child: Icon(Icons.arrow_back, size: 32, color: ColorStyles.appTextColor),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 15,
              right: MediaQuery.of(context).size.width / 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Visibility(
                    visible: _showIcons,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: 25,
                            width: 55,
                            alignment: Alignment.topRight,
                            child: InkWell(
                              child: Icon(Icons.autorenew,
                                  size: 32,
                                  color: imageName == 'zikir.jpg'
                                      ? ColorStyles.appBackGroundColor
                                      : ColorStyles.appTextColor),
                              onTap: () => _resetCounter(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: 25,
                            width: 55,
                            alignment: Alignment.topRight,
                            child: InkWell(
                              child: Icon(Icons.dark_mode,
                                  size: 32,
                                  color: imageName == 'zikir.jpg'
                                      ? ColorStyles.appBackGroundColor
                                      : ColorStyles.appTextColor),
                              onTap: () {
                                setState(() {
                                  _showIcons = !_showIcons;
                                  imageName = imageName == 'zikir.jpg' ? 'meshed.jpeg' : 'zikir.jpg';
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !_showIcons,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        child: Icon(Icons.settings,
                            size: 32,
                            color:
                                imageName == 'zikir.jpg' ? ColorStyles.appBackGroundColor : ColorStyles.appTextColor),
                        onTap: () {
                          setState(() {
                            _showIcons = !_showIcons;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counter') ?? 9;
      isVibrationEnabled = prefs.getBool('vibration') ?? true;
    });
  }

  _incrementCounter() async {
    if (isVibrationEnabled && (await Vibration.hasVibrator())) {
      Vibration.vibrate(duration: 24);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = counter + 1;
    });
    prefs.setInt('counter', counter);
  }

  _resetCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _showIcons = !_showIcons;
      counter = 0;
    });
    prefs.setInt('counter', counter);
  }
}
