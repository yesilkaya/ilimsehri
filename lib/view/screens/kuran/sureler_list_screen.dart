import 'package:flutter/material.dart';

import '../../../constant/color_styles.dart';
import '../../../helper/database_helper.dart';
import '../../models/sure.dart';
import 'sure_detail_screen.dart';

class SurelerListScreen extends StatefulWidget {
  const SurelerListScreen({super.key});

  @override
  SurelerListScreenState createState() => SurelerListScreenState();
}

class SurelerListScreenState extends State<SurelerListScreen> {
  List<Sure> tumSureler = [];
  List<Sure> items = [];
  DatabaseHelper databaseHelper = DatabaseHelper();

  SurelerListScreenState() {
    surelerFromDB();
    surelerFromDB2();
  }

  Color color = const Color.fromRGBO(46, 45, 69, 1);
  Color cardColor = const Color.fromRGBO(46, 45, 69, 0.5);
  Color color2 = const Color.fromRGBO(238, 226, 126, 1);
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              "Kur'an-ı Kerim",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
            pinned: true,
            backgroundColor: ColorStyles.appBackGroundColor,
            leading: const BackButton(
              color: ColorStyles.appTextColor,
            ),
          ),
          SliverAppBar(
            backgroundColor: ColorStyles.appBackGroundColor,
            expandedHeight: 200,
            flexibleSpace: Stack(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    color: ColorStyles.appBackGroundColor,
                    image: DecorationImage(
                      alignment: Alignment.center,
                      image: AssetImage("assets/img/bismillah3.jpg"),
                    ),
                  ),
                ),
              ],
            ),
            leading: Container(),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            sureListWidget(),
          )),
        ],
      ),
    );
  }

  sureListWidget() {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          style: TextStyle(color: color2, fontSize: 18),
          onChanged: (value) {
            filterSearchResults(value);
          },
          controller: editingController,
          cursorColor: color2,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: color2),
            labelStyle: TextStyle(
              color: color2,
              fontSize: 22,
            ),
            filled: true,
            fillColor: color,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: color2), borderRadius: const BorderRadius.all(Radius.circular(25.0))),
            labelText: " Sure ",
            hintText: "Sure",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: color2), borderRadius: const BorderRadius.all(Radius.circular(25.0))),
            prefixIcon: Icon(
              Icons.search,
              color: color2,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: color2), borderRadius: const BorderRadius.all(Radius.circular(25.0))),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.all(10),
        color: color,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: tumSureler.length,
          itemBuilder: (context, index) {
            return tumSureler.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : InkWell(
                    onTap: () {
                      sureyeGit(tumSureler[index]);
                    },
                    child: Card(
                      color: cardColor,
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: ListTile(
                        title: Text(
                          tumSureler[index].sure_adi ?? '',
                          style: TextStyle(color: color2),
                        ),
                        leading: Text(
                          tumSureler[index].sure_id.toString(),
                          style: TextStyle(color: color2, fontSize: 20),
                        ),
                        subtitle: Text(
                          "Ayet Sayısı : ${tumSureler[index].sure_ayet_sayisi}",
                          style: TextStyle(color: color2),
                        ),
                        trailing: Text(
                          tumSureler[index].sure_arapca ?? '',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: color2),
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    ];
  }

  //
  void filterSearchResults(String query) {
    List<Sure> dummySearchList = [];
    dummySearchList.addAll(items);
    if (query.isNotEmpty) {
      List<Sure> dummyListData = [];

      for (var item in dummySearchList) {
        if (item.sure_adi!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        tumSureler.clear();
        tumSureler.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        tumSureler.clear();
        tumSureler.addAll(items);
      });
    }
  }

  void surelerFromDB() {
    databaseHelper.sureListesiniGetir().then((surelerListesi) {
      setState(() {
        tumSureler = surelerListesi;
      });
    });
  }

  void surelerFromDB2() {
    databaseHelper.sureListesiniGetir().then((surelerListesi) {
      setState(() {
        items = surelerListesi;
      });
    });
  }

  void sureyeGit(Sure gonderilenSure) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SureDetailScreen(sure: gonderilenSure)));
  }
}
