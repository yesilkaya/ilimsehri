import 'package:flutter/material.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/constants.dart';
import '../../../helper/text_helper.dart';
import 'munacat_detail_screen.dart';

class MunacatlarScreen extends StatefulWidget {
  const MunacatlarScreen({super.key});

  @override
  MunacatlarScreenState createState() => MunacatlarScreenState();
}

class MunacatlarScreenState extends State<MunacatlarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'Munacatlar',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
            pinned: true,
            backgroundColor: ColorStyles.appBackGroundColor,
            leading: SizedBox(
              width: 12,
              height: 12,
              child: BackButton(
                style: ButtonStyle(iconSize: MaterialStateProperty.all(24.0)),
                color: ColorStyles.appTextColor,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsets.all(30)),
          SliverAppBar(
            backgroundColor: ColorStyles.appBackGroundColor,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: AssetImage("assets/img/bismillah.jpg"),
                ),
              ),
            ),
            leading: Container(),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              dualarListWidget(context),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> dualarListWidget(BuildContext context) {
  List<String> imageNames = [
    'aile',
    'celebrating-eid',
    'crescent',
    'dua-hands',
    'geometric',
    'infaq',
    'islam',
    'islamic',
    'istanbul',
    'kaaba',
    'kandil',
    'koran',
    'man',
    'man2',
    'moslem-woman',
    'mosque',
    'muslim',
    'night',
    'pray',
    'praying',
    'quran',
    'ramadan',
    'ruku',
    'seclusion',
    'tasbih',
    'teachings'
  ];
  return <Widget>[
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      color: ColorStyles.appBackGroundColor,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Constants.munacatlar.length,
        itemBuilder: (context, index) {
          return Constants.munacatlar.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => MunacatDetailScreen(munacatID: index + 1)));
                  },
                  child: Card(
                    color: ColorStyles.cardColor,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: ListTile(
                      title: Text(
                        TextHelper.capitalizeWords(Constants.munacatlar[index]),
                        style: const TextStyle(color: ColorStyles.appTextColor, fontSize: 14, fontFamily: 'Montserrat'),
                      ),
                      leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset('assets/img/icons/${imageNames[index]}.png')),
                    ),
                  ),
                );
        },
      ),
    ),
  ];
}
