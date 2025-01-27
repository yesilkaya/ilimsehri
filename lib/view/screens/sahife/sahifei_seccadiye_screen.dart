import 'package:flutter/material.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/constants.dart';
import 'sahifei_seccadiye_detail_screen.dart';

class SahifeiSeccadiyeScreen extends StatefulWidget {
  @override
  _SahifeiSeccadiyeScreenState createState() => _SahifeiSeccadiyeScreenState();
}

class _SahifeiSeccadiyeScreenState extends State<SahifeiSeccadiyeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                'Sahife-i Seccadiye',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              centerTitle: true,
              pinned: true,
              backgroundColor: ColorStyles.appBackGroundColor,
              leading: const BackButton(color: ColorStyles.appTextColor),
            ),
            SliverAppBar(
              backgroundColor: ColorStyles.appBackGroundColor,
              expandedHeight: 180,
              flexibleSpace: Stack(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
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
                sureListWidget(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> sureListWidget(BuildContext context) {
  List<String> sahifeList = Constants.sahifeSeccadiyeArray;

  return <Widget>[
    Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      color: ColorStyles.appBackGroundColor,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: sahifeList.length,
        itemBuilder: (context, index) {
          return sahifeList.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SahifeiSeccadiyeDetailScreen(duaId: index, duaAdi: sahifeList[index])));
                  },
                  child: Card(
                    color: ColorStyles.cardColor,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: ListTile(
                      title: Text(
                        sahifeList[index],
                        style: const TextStyle(color: ColorStyles.appTextColor, fontSize: 14, fontFamily: 'Montserrat'),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.1),
                        child: Text(
                          index.toString(),
                          style: const TextStyle(color: ColorStyles.appTextColor, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    ),
  ];
}
