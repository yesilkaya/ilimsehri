// Kitap Detay Sayfası
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/color_styles.dart';
import '../../../helper/text_helper.dart';
import '../../../providers/font_size_provider.dart';
import 'aylarin_amelleri.dart';

class AylarinAmelleriDetailPage extends ConsumerWidget {
  final AylarinAmelleriJsonModel ayinAmelleri;

  const AylarinAmelleriDetailPage({super.key, required this.ayinAmelleri});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize = ref.watch(fontSizeProvider);

    return Scaffold(
      backgroundColor: ColorStyles.sepya,
      appBar: AppBar(
        backgroundColor: ColorStyles.appBackGroundColor,
        centerTitle: true,
        title: Text(
          TextHelper.capitalizeWords(ayinAmelleri.title),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 16,
                color: ColorStyles.appTextColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: const BackButton(color: ColorStyles.appTextColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Text(
                ayinAmelleri.title,
                style: TextStyle(fontSize: fontSize + 4, fontWeight: FontWeight.bold, color: ColorStyles.kahveRengi),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(ayinAmelleri.content, style: TextStyle(fontSize: fontSize, color: ColorStyles.kahveRengi)),
            ],
          ),
        ),
      ),
    );
  }
}
