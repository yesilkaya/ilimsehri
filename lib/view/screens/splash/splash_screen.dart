import 'package:flutter/material.dart';

import '../home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }

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
          Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: const Center(
                    child: const Card(
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
              ),
              const Expanded(
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
