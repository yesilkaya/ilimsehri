import 'package:flutter/material.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/list_type.dart';
import '../../../helper/database_helper.dart';
import '../../../helper/list_helper.dart';
import '../../models/sahifeyi_seccadiye.dart';

class SahifeiSeccadiyeDetailScreen extends StatefulWidget {
  final int duaId;
  final String duaAdi;
  const SahifeiSeccadiyeDetailScreen({super.key, required this.duaAdi, required this.duaId});
  @override
  SahifeiSeccadiyeDetailScreenState createState() => SahifeiSeccadiyeDetailScreenState();
}

class SahifeiSeccadiyeDetailScreenState extends State<SahifeiSeccadiyeDetailScreen> {
  List<SahifeiSeccadiye> duaList = [];
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    duaListesiniDoldur();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListHelper helper = ListHelper(list: duaList, listType: ListType.sahife, title: widget.duaAdi);

    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              widget.duaAdi,
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

  void duaListesiniDoldur() {
    databaseHelper.sahifeiSeccadiyeDuaListeGetir(widget.duaId).then((gelenListe) {
      setState(() {
        duaList = gelenListe;
      });
    });
  }
}
