import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/constants.dart';
import '../../../constant/list_type.dart';
import '../../../helper/database_helper.dart';
import '../../../helper/ramazan_list_helper.dart';
import '../../../helper/text_helper.dart';
import '../../models/ramazan.dart';

class RamazanDetailScreen extends ConsumerStatefulWidget {
  final int ramazanAmelID;

  const RamazanDetailScreen({super.key, required this.ramazanAmelID});

  @override
  RamazanDetailScreenState createState() => RamazanDetailScreenState();
}

class RamazanDetailScreenState extends ConsumerState<RamazanDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  late SharedPreferences _prefs;
  double _savedScrollOffset = 0.0;

  List<Ramazan> ramazanAmelList = [];
  String? duaAdi = "";
  String? duaArapca = "";
  String? duaTurkce = "";
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    duaAdi = Constants.ramazanAyiAmelleri[widget.ramazanAmelID];
    _ramazanAmelGetir();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RamazanListHelper helper = RamazanListHelper(list: ramazanAmelList, title: duaAdi ?? "");

    return Scaffold(
      backgroundColor: ColorStyles.sepya,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              TextHelper.capitalizeWords(duaAdi ?? ""),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 16, color: ColorStyles.appTextColor, fontWeight: FontWeight.bold),
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
                return helper.getList(widget.ramazanAmelID);
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  void _ramazanAmelGetir() {
    duaAdi = Constants.ramazanAyiAmelleri[widget.ramazanAmelID];
    databaseHelper.ramazanAmelListeGetir(widget.ramazanAmelID + 1).then((value) {
      setState(() {
        ramazanAmelList = value;
      });
    });
    _loadScrollPosition();
  }

  Future<void> _loadScrollPosition() async {
    _prefs = await SharedPreferences.getInstance();
    _savedScrollOffset = _prefs.getDouble('${ListType.ramazan}_${duaAdi}_scrollOffset') ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_savedScrollOffset);
    });
  }

  Future<void> _changeBookMarkStatus() async {
    setState(() {
      _savedScrollOffset = _savedScrollOffset == 0 ? _scrollController.offset : 0;
    });
    await _prefs.setDouble('${ListType.ramazan}_${duaAdi}_scrollOffset', _savedScrollOffset);
  }
}
