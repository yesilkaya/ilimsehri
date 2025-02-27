import 'package:flutter/material.dart';

import '../home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: checkDate() ? 4 : 2)).then((value) {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return checkDate() ? const RamazanSplash() : const DefaultSplash();
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
          fit: BoxFit.cover, // Resmi ekranı kaplayacak şekilde ölçeklendirir
        ),
      ),
    );
  }
}
