import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/color_styles.dart';
import '../../../constant/constants.dart';
import '../../../constant/list_type.dart';
import '../../../helper/database_helper.dart';
import '../../../helper/list_helper.dart';
import '../../../helper/sound_name.dart';
import '../../../helper/text_helper.dart';
import '../../../widgets/play_sound_widget.dart';
import '../../models/dua.dart';

class DuaDetailScreen extends ConsumerStatefulWidget {
  final int duaID;

  const DuaDetailScreen({super.key, required this.duaID});

  @override
  DuaDetailScreenState createState() => DuaDetailScreenState();
}

class DuaDetailScreenState extends ConsumerState<DuaDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  List<Dua> duaList = [];
  String? duaAdi = "";
  String? duaArapca = "";
  String? duaTurkce = "";
  DatabaseHelper databaseHelper = DatabaseHelper();
  bool isPlaySound = false;

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    _duaGetir();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ListHelper helper = ListHelper(list: duaList, listType: ListType.dua, title: duaAdi ?? "");
    String? duaSoundPath = SoundNames.getDuaSoundPath(duaAdi);

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
            actions: [
              if (duaSoundPath != null)
                IconButton(
                  icon: Icon(isPlaySound == false ? Icons.play_circle : Icons.pause),
                  color: ColorStyles.appTextColor,
                  onPressed: () {
                    setState(() {
                      isPlaySound = !isPlaySound;
                    });
                  },
                ),
            ],
          ),
          if (isPlaySound == true && duaSoundPath != null)
            SliverToBoxAdapter(
              child: AudioPlayerWidget(
                soundPath: duaSoundPath,
              ),
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

  void _duaGetir() {
    duaAdi = Constants.dualar[widget.duaID];
    databaseHelper.duaListeGetir(widget.duaID + 1).then((value) {
      setState(() {
        duaList = value;
      });

      /*Future.delayed(const Duration(milliseconds: 300), () {
        double scrollOffset = 20 * _scrollController.position.maxScrollExtent / duaList.length;
        _scrollController.animateTo(
          scrollOffset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
      */
    });
  }
}
