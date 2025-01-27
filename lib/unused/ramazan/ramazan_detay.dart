import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../constant/constants.dart';
import '../../helper/database_helper.dart';
import '../../view/models/ramazan.dart';

class RamazanDetay extends StatefulWidget {
  final int ramazanID;
  RamazanDetay({required this.ramazanID});

  @override
  _RamazanDetayState createState() => _RamazanDetayState();
}

class _RamazanDetayState extends State<RamazanDetay> {
  List<Ramazan> ramazanList = [];
  DatabaseHelper databaseHelper = DatabaseHelper();
  String? munacatAdi = "";
  String? munacatArapca = "";
  String? munacatTurkce = "";
  String? dataArapca;
  String? dataTurkce;
  String? dataTurkce2;
  String duaAdi = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    duaAdi = Constants.ramazanAyiAmelleri[widget.ramazanID - 1];
    duaGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image(
                    image: AssetImage("assets/img/ehlibeyt/masum1_${10}.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            toolbarHeight: 100,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(
                duaAdi,
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          SliverList(
              delegate: new SliverChildListDelegate(
            _herGununDuasi(),
          )),
        ],
      ),
    );
  }

  // Widget _duaListesi(BuildContext context, int index) {
  //
  //   return ListView.builder(
  //       scrollDirection: Axis.vertical,
  //       shrinkWrap: true,
  //       itemCount: 10,
  //       itemBuilder: (context, index) {
  //         return Container(height: 300,child: Text("Merhaba"));
  //       });
  // }

  List<Widget> _herGununDuasi() {
    List<Widget> listItems = [];

    if (widget.ramazanID == 1 || widget.ramazanID == 5 || widget.ramazanID == 6) {
      // her günün duasi
      for (int i = 0; i < ramazanList.length; i++) {
        listItems.add(
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: <Widget>[
                widget.ramazanID == 1
                    ? Text(
                        "${i + 1}. gün",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )
                    : Text(""),
                SizedBox(
                  height: 15,
                ),
                Text(
                  ramazanList[i].arapca ?? '',
                  //style: TextStyle(color: Colors.black,fontSize: 20,)
                  style: Theme.of(context).textTheme.headlineMedium,
                  textDirection: TextDirection.rtl, textAlign: TextAlign.justify,
                ),
                SizedBox(height: 15),
                Text(
                  ramazanList[i].turkce ?? "",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  ramazanList[i].meal ?? "",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Constants.color2,
                  height: 3,
                ),
              ],
            ),
          ),
        );
      }
    } else if (widget.ramazanID == 2) {
      // Her gecenin namazi
      for (int i = 0; i < ramazanList.length; i++) {
        listItems.add(
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                Text(
                  "${i + 1}. gece",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ramazanList[i].arapca ?? '',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Divider(
                  color: Constants.color2,
                  height: 3,
                ),
              ],
            ),
          ),
        );
      }
    } else if (widget.ramazanID == 3) {
      for (int i = 0; i < ramazanList.length; i++) {
        listItems.add(
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                HtmlWidget(ramazanList[i].turkce ?? ''),

                //Text(ramazanList[i]?.turkce ?? "" ,style: TextStyle(color: Colors.black)),
                SizedBox(
                  height: 15,
                ),
                HtmlWidget(ramazanList[i].meal ?? ''),

                //   Text(ramazanList[i]?.meal ?? "",style: TextStyle(color: Colors.black)),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Constants.color2,
                  height: 2,
                ),
              ],
            ),
          ),
        );
      }
    } else if (widget.ramazanID == 4) {
      for (int i = 0; i < ramazanList.length; i++) {
        listItems.add(
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                HtmlWidget(ramazanList[i].arapca ?? ''),

                //Text(ramazanList[i]?.turkce ?? "" ,style: TextStyle(color: Colors.black)),
                SizedBox(
                  height: 15,
                ),
                HtmlWidget(ramazanList[i].turkce ?? ''),

                //   Text(ramazanList[i]?.meal ?? "",style: TextStyle(color: Colors.black)),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Constants.color2,
                  height: 2,
                ),
              ],
            ),
          ),
        );
      }
    }

    return listItems;
  }

  void duaGetir() {
    databaseHelper.ramazanAmelListeGetir(widget.ramazanID).then((value) {
      setState(() {
        ramazanList = value;
      });
    });
  }
}
