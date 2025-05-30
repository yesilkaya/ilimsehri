import 'package:flutter/material.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/constants.dart';
import '../../../helper/sound_name.dart';
import 'dua_detail_screen.dart';

class DualarScreen extends StatefulWidget {
  const DualarScreen({super.key});

  @override
  DualarScreenState createState() => DualarScreenState();
}

class DualarScreenState extends State<DualarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'Dualar',
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
              dualarListWidget(context),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> dualarListWidget(BuildContext context) {
  return <Widget>[
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      color: ColorStyles.appBackGroundColor,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Constants.dualar.length,
        itemBuilder: (context, index) {
          String? duaSoundPath = SoundNames.getDuaSoundPath(Constants.dualar[index]);
          return Constants.dualar.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DuaDetailScreen(duaID: index)));
                  },
                  child: Card(
                    color: ColorStyles.cardColor,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: ListTile(
                      title: Text(
                        Constants.dualar[index],
                        style: const TextStyle(color: ColorStyles.appTextColor, fontSize: 14, fontFamily: 'Montserrat'),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.1),
                        child: Text(
                          (index + 1).toString(),
                          style: const TextStyle(color: ColorStyles.appTextColor, fontSize: 20),
                        ),
                      ),
                      trailing: duaSoundPath != null
                          ? Icon(
                              Icons.music_note,
                              size: 16,
                              color: ColorStyles.appTextColor.withOpacity(0.6),
                            )
                          : null,
                    ),
                  ),
                );
        },
      ),
    ),
  ];
}
