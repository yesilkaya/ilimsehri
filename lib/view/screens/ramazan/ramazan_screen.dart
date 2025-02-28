import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilimsehri/view/screens/ramazan/ramazan_detail_screen.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/constants.dart';
import '../imsakiye_screen.dart';

class RamazanScreen extends StatefulWidget {
  const RamazanScreen({super.key});

  @override
  RamazanScreenState createState() => RamazanScreenState();
}

class RamazanScreenState extends State<RamazanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                'Ramazan Ayı Amelleri',
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
                ramazanListWidget(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> ramazanListWidget(BuildContext context) {
  return <Widget>[
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      color: ColorStyles.appBackGroundColor,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Constants.ramazanAyiAmelleri.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FullScreenImagePage()));
              },
              child: Card(
                color: ColorStyles.cardColor,
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: ListTile(
                  title: const Text(
                    'Ramazan İmsakiyesi',
                    style: TextStyle(color: ColorStyles.appTextColor, fontSize: 14, fontFamily: 'Montserrat'),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: Colors.transparent, child: SvgPicture.asset('assets/img/svg/takvim.svg')),
                ),
              ),
            );
          }
          return Constants.ramazanAyiAmelleri.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RamazanDetailScreen(ramazanAmelID: index - 1)));
                  },
                  child: Card(
                    color: ColorStyles.cardColor,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: ListTile(
                      title: Text(
                        Constants.ramazanAyiAmelleri[index - 1],
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
