import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final ScrollController _scrollController = ScrollController();
  late SharedPreferences _prefs;
  double _savedScrollOffset = 0.0;

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
        controller: _scrollController,
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
            actions: [
              IconButton(
                icon: Icon(
                  _savedScrollOffset == 0 ? Icons.bookmark_add_outlined : Icons.bookmark,
                  color: ColorStyles.appTextColor,
                ),
                onPressed: _changeBookMarkStatus,
              ),
            ],
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

  Future<void> _munacatGetir() async {
    await databaseHelper.munacatListeGetir(widget.munacatID).then((value) {
      setState(() {
        munacatList = value;
        munacatAdi = value[0].munacat_adi;
      });
    });
    _loadScrollPosition();
  }

  Future<void> _loadScrollPosition() async {
    _prefs = await SharedPreferences.getInstance();
    _savedScrollOffset = _prefs.getDouble('${ListType.munacat}_${munacatAdi}_scrollOffset') ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_savedScrollOffset);
    });
  }

  Future<void> _changeBookMarkStatus() async {
    setState(() {
      _savedScrollOffset = _savedScrollOffset == 0 ? _scrollController.offset : 0;
    });
    await _prefs.setDouble('${ListType.munacat}_${munacatAdi}_scrollOffset', _savedScrollOffset);
  }
}
