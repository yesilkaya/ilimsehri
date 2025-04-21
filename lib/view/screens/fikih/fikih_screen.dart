import 'package:flutter/material.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/constants.dart';
import '../tefsir/tefsir_detail_screen.dart';

class FikihScreen extends StatefulWidget {
  const FikihScreen({super.key});

  @override
  FikihScreenState createState() => FikihScreenState();
}

class FikihScreenState extends State<FikihScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'Fıkıh',
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
              fikihListWidget(context),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> fikihListWidget(BuildContext context) {
  return <Widget>[
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      color: ColorStyles.appBackGroundColor,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Constants.fikih.length,
        itemBuilder: (context, index) {
          return Constants.fikih.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TefsirDetailScreen(
                                  title: Constants.fikih[index].title ?? "",
                                  tefsirPdfLink: Constants.fikih[index].pdfUrl ?? '',
                                  index: index,
                                )));
                  },
                  child: Card(
                    color: ColorStyles.cardColor,
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: ListTile(
                      title: Text(
                        Constants.fikih[index].title ?? '',
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
