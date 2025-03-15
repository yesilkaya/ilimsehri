import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/constants.dart';
import '../../../helper/database_helper.dart';
import '../../../helper/text_helper.dart';
import '../../../providers/font_size_provider.dart';

class EhlibeytDetailScreen extends ConsumerStatefulWidget {
  final int ehlibeytID;

  const EhlibeytDetailScreen({super.key, required this.ehlibeytID});

  @override
  EhlibeytDetailScreenState createState() => EhlibeytDetailScreenState();
}

class EhlibeytDetailScreenState extends ConsumerState<EhlibeytDetailScreen> {
  String data = "";
  String? ehlibeytAdi = "";
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    _ehlibeytGetir();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = ref.watch(fontSizeProvider);

    return Scaffold(
      backgroundColor: ColorStyles.sepya,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              TextHelper.capitalizeWords(ehlibeytAdi ?? ""),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 16, color: ColorStyles.appTextColor, fontWeight: FontWeight.bold),
              maxLines: 3,
            ),
            centerTitle: true,
            pinned: true,
            backgroundColor: ColorStyles.appBackGroundColor,
            leading: const BackButton(color: ColorStyles.appTextColor),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: HtmlWidget(
                    data,
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                      height: 1.6,
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _ehlibeytGetir() async {
    ehlibeytAdi = Constants.ehlibeyt[widget.ehlibeytID];
    await databaseHelper.ehlibeytinHayatiListeGetir(widget.ehlibeytID + 1).then((value) {
      setState(() {
        data = value;
      });
    });
  }
}
