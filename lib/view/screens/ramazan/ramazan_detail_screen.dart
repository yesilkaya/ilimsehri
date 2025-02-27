import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/constants.dart';
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
        print('ramazanAmelList arapça: ${ramazanAmelList[0].arapca}');
        print('ramazanAmelList türkçe: ${ramazanAmelList[0].turkce}');
        print('ramazanAmelList meal: ${ramazanAmelList[0].meal}');
      });
    });
  }
}
