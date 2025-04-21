import 'package:flutter/material.dart';
import 'package:ilimsehri/view/screens/tefsir/tefsir_detail_screen.dart';

import '../../../constant/color_styles.dart';
import '../../models/el_mizan.dart';

class TefsirListScreen extends StatefulWidget {
  const TefsirListScreen({super.key});

  @override
  TefsirListScreenState createState() => TefsirListScreenState();
}

class TefsirListScreenState extends State<TefsirListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              "El-Mizan Tefsiri",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            centerTitle: true,
            pinned: true,
            backgroundColor: ColorStyles.appBackGroundColor,
            leading: const BackButton(
              color: ColorStyles.appTextColor,
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
            _buildListView(),
          )),
        ],
      ),
    );
  }

  _buildListView() {
    return <Widget>[
      Container(
        color: ColorStyles.appBackGroundColor,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: ElMizan.elMizanCiltList.length,
          itemBuilder: (context, index) {
            final tefsir = ElMizan.elMizanCiltList[index];

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TefsirDetailScreen(title: 'Cilt ${index + 1}', tefsirPdfLink: tefsir.link, index: index),
                  ),
                );
              },
              child: Card(
                color: ColorStyles.cardColor,
                elevation: 2,
                margin: const EdgeInsets.all(10),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(
                    color: ColorStyles.appTextColor, // Burada border rengini seçebilirsiniz
                    width: 0.5, // Border kalınlığını belirleyebilirsiniz
                  ),
                ),
                child: ListTile(
                  title: Text(
                    tefsir.name,
                    style: const TextStyle(color: ColorStyles.color2),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ];
  }
}
