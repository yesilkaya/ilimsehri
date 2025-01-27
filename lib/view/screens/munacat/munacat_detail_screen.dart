import 'package:flutter/material.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/list_type.dart';
import '../../../helper/database_helper.dart';
import '../../../helper/list_helper.dart';
import '../../../helper/text_helper.dart';
import '../../models/munacat.dart';

class MunacatDetailScreen extends StatefulWidget {
  final int munacatID;

  const MunacatDetailScreen({super.key, required this.munacatID});
  @override
  MunacatDetailScreenState createState() => MunacatDetailScreenState();
}

class MunacatDetailScreenState extends State<MunacatDetailScreen> {
  List<Munacat> munacatList = [];
  String? munacatAdi = "";

  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    databaseHelper = DatabaseHelper();
    _munacatGetir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListHelper helper = ListHelper(list: munacatList, listType: ListType.munacat, title: munacatAdi ?? "");

    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              TextHelper.capitalizeWords(munacatAdi ?? ""),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 14, color: ColorStyles.appTextColor, fontWeight: FontWeight.bold),
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
                return helper.getList();
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  void _munacatGetir() {
    databaseHelper.munacatListeGetir(widget.munacatID).then((value) {
      setState(() {
        munacatList = value;
        munacatAdi = value[0].munacat_adi;
      });
    });
  }
}
