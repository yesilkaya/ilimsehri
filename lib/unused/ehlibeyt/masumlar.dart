import 'package:flutter/material.dart';

import '../../constant/constants.dart';
import 'masum_hayat.dart';

class Masumlar extends StatefulWidget {
  static const String imgPath = "";

  @override
  _MasumlarState createState() => _MasumlarState();
}

class _MasumlarState extends State<Masumlar> {
  List<String> masumlar = Constants.masumlar;
  String? imgPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.gridColor2,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image(
                    image: AssetImage('assets/img/allah/allah1.jpg'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            toolbarHeight: 150,
            pinned: true,
          ),

          /* SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
            crossAxisSpacing: 45,
            childAspectRatio: 1,
            mainAxisSpacing: 30),
            delegate: SliverChildListDelegate(sabitElemanlari(),addAutomaticKeepAlives: true),
          ),*/
          SliverPadding(
            padding: EdgeInsets.all(1),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  //  crossAxisSpacing: 45,
                  //  mainAxisSpacing: 30,
                  //   childAspectRatio: 1,
                  crossAxisCount: 2),
              delegate: SliverChildBuilderDelegate(_dinamikMasumlarListesi, childCount: 14),
            ),
          ),
        ],
      ),
    );
  }

/*
  List<Widget> sabitElemanlari() {
    return [
    Container(

      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/img/ehlibeyt/masum2.png"),
        ),
      ),
    ),
    Container(

      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/img/ehlibeyt/masum2.png"),
        ),
      ),
    ),
    Container(

      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/img/ehlibeyt/masum3.png"),
        ),
      ),
    ),
    Container(

      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/img/ehlibeyt/masum4.png"),
        ),
      ),
    ),
    Container(

      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/img/ehlibeyt/masum5.png"),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/img/ehlibeyt/masum6.png"),
        ),
      ),
    ),
    Container(

      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/img/ehlibeyt/masum7.png"),
        ),
      ),
    ),
    Container(

      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/img/ehlibeyt/masum8.png"),
        ),
      ),
    ),
    Container(

      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/img/ehlibeyt/masum9.png"),
        ),
      ),
    ),
    Container(

      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/img/ehlibeyt/masum10.png"),
        ),
      ),
    ),
    Container(

      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/img/ehlibeyt/masum11.png"),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/img/ehlibeyt/masum12.png"),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/img/ehlibeyt/masum13.png"),
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        shape: BoxShape.circle,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/img/ehlibeyt/masum14.png"),
        ),
      ),
    ),

    ];

  }
*/
  Widget _dinamikMasumlarListesi(BuildContext context, int index) {
    imgPath = "assets/img/ehlibeyt/masum1_${index + 1}.png";
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MasumlarinHayati(masumId: index),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        margin: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                decoration: BoxDecoration(
                  //     color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Container(
                  child: Image(
                    image: AssetImage(imgPath ?? ''),
                    fit: BoxFit.cover,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                ),
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.all(5),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                masumlar[index],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
