import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final ScrollController _scrollController = ScrollController();
  late SharedPreferences _prefs;
  double _savedScrollOffset = 0.0;

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
        controller: _scrollController,
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

  Future<void> duaListesiniDoldur() async {
    await databaseHelper.sahifeiSeccadiyeDuaListeGetir(widget.duaId).then((gelenListe) {
      setState(() {
        duaList = gelenListe;
      });
    });
    _loadScrollPosition();
  }

  Future<void> _loadScrollPosition() async {
    _prefs = await SharedPreferences.getInstance();
    _savedScrollOffset = _prefs.getDouble('${ListType.sahife}_${widget.duaAdi}_scrollOffset') ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_savedScrollOffset);
    });
  }

  Future<void> _changeBookMarkStatus() async {
    setState(() {
      _savedScrollOffset = _savedScrollOffset == 0 ? _scrollController.offset : 0;
    });
    await _prefs.setDouble('${ListType.sahife}_${widget.duaAdi}_scrollOffset', _savedScrollOffset);
  }
}
