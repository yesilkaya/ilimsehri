import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../helper/database_helper.dart';
import '../../view/models/ehlibeyt.dart';

class MasumlarinHayati extends StatefulWidget {
  final int? masumId;
  MasumlarinHayati({this.masumId});

  @override
  _MasumlarinHayatiState createState() => _MasumlarinHayatiState();
}

class _MasumlarinHayatiState extends State<MasumlarinHayati> {
  List<Ehlibeyt>? ehlibeytinHayati;
  DatabaseHelper? databaseHelper;
  String data = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseHelper = DatabaseHelper();
    //List<Ehlibeyt> ehlibeytinHayati = [];
    _ehlibeytinHayatiDoldur();
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
                    image: AssetImage("assets/img/ehlibeyt/masum1_${widget.masumId ?? 0 + 1}.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            toolbarHeight: 150,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: HtmlWidget(data),
            ),
          ),
        ],
      ),
    );
  }

  void _ehlibeytinHayatiDoldur() {
    databaseHelper?.ehlibeytinHayatiListeGetir(widget.masumId ?? 0 + 1).then((value) {
      setState(() {
        data = value;
      });
    });
  }
}
