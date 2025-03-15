import 'package:flutter/material.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/constants.dart';
import 'ehlibeyt_detail_screen.dart';

class EhlibeytScreen extends StatefulWidget {
  const EhlibeytScreen({super.key});

  @override
  EhlibeytScreenState createState() => EhlibeytScreenState();
}

class EhlibeytScreenState extends State<EhlibeytScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'Ehlibeyt',
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
              ehlibeytListWidget(context),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> ehlibeytListWidget(BuildContext context) {
  return <Widget>[
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      color: ColorStyles.appBackGroundColor,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Constants.ehlibeyt.length,
        itemBuilder: (context, index) {
          return Constants.ehlibeyt.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => EhlibeytDetailScreen(ehlibeytID: index)));
                  },
                  child: Card(
                    color: ColorStyles.cardColor,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: ListTile(
                      title: Text(
                        Constants.ehlibeyt[index],
                        style: const TextStyle(color: ColorStyles.appTextColor, fontSize: 14, fontFamily: 'Montserrat'),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.1),
                        child: Text(
                          (index + 1).toString(),
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
