import 'package:flutter/material.dart';

import '../../../../constant/color_styles.dart';
import '../../../../helper/database_helper.dart';
import '../../../../helper/text_helper.dart';
import '../../../../widgets/play_sound_widget.dart';
import '../../../constant/list_type.dart';
import '../../../helper/list_helper.dart';
import '../../models/ayet.dart';
import '../../models/sure.dart';

class SureDetailScreen extends StatefulWidget {
  final Sure sure;
  final int? ayetId;
  const SureDetailScreen({super.key, required this.sure, this.ayetId});

  @override
  SureDetailScreenState createState() => SureDetailScreenState();
}

class SureDetailScreenState extends State<SureDetailScreen> {
  List<Ayet> ayetList = [];
  DatabaseHelper? databaseHelper;
  String sureAdi = '';
  bool isPlaySound = false;

  @override
  void initState() {
    databaseHelper = DatabaseHelper();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getAyetFromDatabase(widget.sure.sure_id ?? 0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String sureSoundPath = '${sureAdi.split(' ').first.toLowerCase().replaceAll('ü', 'u').replaceAll('ş', 's')}.mp3';
    ListHelper helper = ListHelper(list: ayetList, listType: ListType.sure, title: sureAdi);

    return Scaffold(
      backgroundColor: ColorStyles.sepya,
      appBar: AppBar(
        title: Text(
          TextHelper.capitalizeWords(sureAdi),
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 16, color: ColorStyles.appTextColor, fontWeight: FontWeight.bold),
          maxLines: 3,
        ),
        centerTitle: true,
        backgroundColor: ColorStyles.appBackGroundColor,
        leading: const BackButton(
          color: ColorStyles.appTextColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isPlaySound == true && sureAdi.isNotEmpty)
              Expanded(
                child: SliverToBoxAdapter(
                  child: AudioPlayerWidget(
                    soundPath: sureSoundPath,
                  ),
                ),
              ),
            helper.getList(),
          ],
        ),
      ),
    );
  }

  void _getAyetFromDatabase(int sureId) {
    if (widget.sure.sure_adi != null) sureAdi = "${widget.sure.sure_adi!} Suresi";

    databaseHelper?.ayetlerListGetir(sureId).then((ayetleriIcerenListe) {
      setState(() {
        ayetList = ayetleriIcerenListe;
      });
    });
  }
}
