import 'package:flutter/material.dart';
import 'package:ilimsehri/view/screens/dua/dualar_screen.dart';
import 'package:ilimsehri/view/screens/munacat/munacatlar_screen.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/constants.dart';
import '../../../helper/text_helper.dart';
import 'sahife/sahifei_seccadiye_screen.dart';

class DuaMunacatScreen extends StatefulWidget {
  const DuaMunacatScreen({super.key});

  @override
  DuaMunacatScreenState createState() => DuaMunacatScreenState();
}

class DuaMunacatScreenState extends State<DuaMunacatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'Dualar ve Münacatlar',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
            pinned: true,
            backgroundColor: ColorStyles.appBackGroundColor,
            leading: SizedBox(
              width: 12,
              height: 12,
              child: BackButton(
                style: ButtonStyle(iconSize: WidgetStateProperty.all(24.0)),
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
    'islam',
    'pray',
    'quran',
  ];
  return <Widget>[
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      color: ColorStyles.appBackGroundColor,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Constants.duaMunacatlar.length,
        itemBuilder: (context, index) {
          return Constants.duaMunacatlar.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : InkWell(
                  onTap: () {
                    index == 0
                        ? Navigator.push(context, MaterialPageRoute(builder: (context) => const DualarScreen()))
                        : index == 1
                            ? Navigator.push(context, MaterialPageRoute(builder: (context) => const MunacatlarScreen()))
                            : Navigator.push(
                                context, MaterialPageRoute(builder: (context) => SahifeiSeccadiyeScreen()));
                  },
                  child: Card(
                    color: ColorStyles.cardColor,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: ListTile(
                      title: Text(
                        TextHelper.capitalizeWords(Constants.duaMunacatlar[index]),
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
