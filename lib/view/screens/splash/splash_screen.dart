import 'dart:async';

import 'package:flutter/material.dart';

import '../home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  Timer? _timer; // To manage the countdown
  bool _isPressed = false; // To track if the image is pressed
  int _delayDuration = 2; // Initial delay duration for the splash screen
  late Duration _remainingTime; // To track the remaining time
  bool _isTimerRunning = false; // To check if the timer is running

  @override
  void initState() {
    super.initState();
    _remainingTime = Duration(seconds: _delayDuration);
    startTimer();
  }

  void startTimer() {
    if (_isTimerRunning) return;

    _isTimerRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds > 0 && !_isPressed) {
        setState(() {
          _remainingTime = Duration(seconds: _remainingTime.inSeconds - 1);
        });
      }

      if (_remainingTime.inSeconds == 0) {
        _timer?.cancel();
        navigateToHomeScreen();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _isTimerRunning = false;
  }

  void resumeTimer() {
    startTimer();
  }

  void navigateToHomeScreen() {
    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (_) {
        // When the user presses on the image, stop the timer
        stopTimer();
      },
      onPanEnd: (_) {
        // When the user releases the image, resume the timer
        resumeTimer();
      },
      child: checkDate() ? const RamazanSplash() : const DefaultSplash(),
    );
  }

  bool checkDate() {
    DateTime now = DateTime.now();
    DateTime startDate = DateTime(2025, 2, 25);
    DateTime endDate = DateTime(2025, 3, 30);

    return now.isAfter(startDate) && now.isBefore(endDate);
  }
}

class DefaultSplash extends StatelessWidget {
  const DefaultSplash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              color: Colors.black,
            ),
          ),
          const Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: Card(
                    color: Colors.black87,
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        '"Gerçekten Hüseyin, Kurtuluş Gemisi ve Hidayet Meşalesidir."\n\n Hz. Muhammed(s.a.v)',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(child: Image(image: AssetImage('assets/img/hekimane.png'))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RamazanSplash extends StatelessWidget {
  const RamazanSplash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SizedBox.expand(
        child: Image.asset(
          'assets/img/ramazan_splash.jpeg',
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
