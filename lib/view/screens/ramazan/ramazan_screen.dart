import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ilimsehri/view/screens/ramazan/ramazan_detail_screen.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/constants.dart';
import '../../../helper/time_helper.dart';
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
      body: CustomScrollView(
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
              ramazanListWidget(context),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> ramazanListWidget(BuildContext context) {
  int listLength = Constants.ramazanAyiAmelleri.length;
  return <Widget>[
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      color: ColorStyles.appBackGroundColor,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: TimeHelper.checkDate() ? listLength + 1 : listLength,
        itemBuilder: (context, index) {
          if (index == 0 && TimeHelper.checkDate()) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ImsakiyeScreen()));
              },
              child: Card(
                color: ColorStyles.cardColor,
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: ListTile(
                  title: const Text(
                    'Ramazan İmsakiyesi (İstanbul)',
                    style: TextStyle(color: ColorStyles.appTextColor, fontSize: 14, fontFamily: 'Montserrat'),
                  ),
                  leading: CircleAvatar(
                      backgroundColor: Colors.transparent, child: SvgPicture.asset('assets/img/svg/takvim.svg')),
                ),
              ),
            );
          }
          List<String> imageNames = ['pray', 'islam', 'seclusion', 'night', 'quran', 'muslim', 'quran', 'muslim'];
          return Constants.ramazanAyiAmelleri.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RamazanDetailScreen(ramazanAmelID: TimeHelper.checkDate() ? index - 1 : index)));
                  },
                  child: Card(
                    color: ColorStyles.cardColor,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: ListTile(
                      title: Text(
                        Constants.ramazanAyiAmelleri[TimeHelper.checkDate() ? index - 1 : index],
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
