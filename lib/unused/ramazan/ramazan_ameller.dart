import 'package:flutter/material.dart';

import '../../constant/constants.dart';
import 'ramazan_detay.dart';

class RamazanAmelleri extends StatefulWidget {
  @override
  _RamazanAmelleriState createState() => _RamazanAmelleriState();
}

class _RamazanAmelleriState extends State<RamazanAmelleri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image(
                    image: AssetImage('assets/img/hekimane2.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ],
            ),
            toolbarHeight: 150,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: _ramazanBaslik(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              _ramazanListWigdet,
              childCount: Constants.ramazanAyiAmelleri.length,
            ),
          ),
        ],
      ),
    );
  }

  _ramazanBaslik() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Text(
        "Ramazan Ayı Amelleri",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _ramazanListWigdet(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RamazanDetay(ramazanID: (index + 1))));
      },
      child: Container(
        height: 75,
        child: Card(
          shadowColor: Colors.black,
          margin: EdgeInsets.all(8),
          elevation: 5,
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Image(
                image: AssetImage("assets/img/hekimane.png"),
                fit: BoxFit.cover,
              ),
              margin: EdgeInsets.all(5),
            ),
            title: Text(
              Constants.ramazanAyiAmelleri[index],
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
