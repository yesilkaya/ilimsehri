import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../constant/color_styles.dart';
import '../../../providers/eyyamullah_provider.dart';
import '../../models/eyyamullah.dart';

class EyyamullahScreen extends ConsumerStatefulWidget {
  const EyyamullahScreen({super.key});

  @override
  EyyamullahScreenState createState() => EyyamullahScreenState();
}

class EyyamullahScreenState extends ConsumerState<EyyamullahScreen> {
  List<Eyyamullah> eyyamullahs = [];
  final List<Color> darkColors = [
    Colors.red.shade900,
    Colors.yellow.shade900,
    Colors.blue.shade900,
    Colors.green.shade900,
    Colors.pink.shade900,
    Colors.cyan.shade900,
  ];
  final random = Random();
  final ScrollController _scrollController = ScrollController();
  int month = DateTime.now().month;
  TextStyle style = const TextStyle(
    color: Colors.white70,
    fontFamily: 'Montserrat',
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() {
    final notifier = ref.read(eyyamullahProvider.notifier);
    notifier.init(ref);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(eyyamullahProvider);
    if (state.isPageReady) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        int targetIndex = state.events!.indexWhere((event) {
          try {
            DateTime date = DateFormat("dd/MM/yyyy").parse(event.gregorianDate);
            return date.month == month;
          } catch (e) {
            print("Tarih formatı hatalı: ${event.gregorianDate}");
            return false;
          }
        });

        if (targetIndex != -1) {
          double itemHeight = 120.0;
          double targetOffset = targetIndex * itemHeight;

          if (_scrollController.hasClients) {
            _scrollController.jumpTo(targetOffset);
          }
        }
      });
    }

    return Scaffold(
      backgroundColor: ColorStyles.sepya,
      appBar: AppBar(
        title: Text('Ehlibeyt Takvimi',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: ColorStyles.appBackGroundColor,
                )),
        centerTitle: true,
        backgroundColor: ColorStyles.sepya,
        leading: const BackButton(
          color: ColorStyles.appBackGroundColor,
        ),
      ),
      body: state.isPageReady
          ? SingleChildScrollView(
              controller: _scrollController,
              child: state.events != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.events!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                index % 2 == 0 ? _getDate(state, index) : _getDecs(state, index),
                                _getLine(),
                                index % 2 == 0 ? _getDecs(state, index) : _getDate(state, index),
                              ],
                            ),
                          ],
                        );
                      },
                    )
                  : Container(),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Expanded _getDecs(Eyyamullah state, int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Card(
          color: state.events![index].description.toLowerCase().contains('şehadet')
              ? Colors.black
              : darkColors[random.nextInt(darkColors.length)],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(state.events![index].description, style: style, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _getLine() {
    return Column(
      children: [
        Container(height: 50, width: 5, color: Colors.grey),
        Container(
          height: 10,
          width: 10,
          decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        ),
        Container(height: 50, width: 5, color: Colors.grey),
      ],
    );
  }

  Expanded _getDate(Eyyamullah state, int index) {
    return Expanded(
      child: Column(
        children: [
          Text(state.events![index].gregorianDate, style: style.copyWith(color: Colors.black)),
          const SizedBox(height: 3),
          Text(state.events![index].hijriDate, style: style.copyWith(color: Colors.black)),
        ],
      ),
    );
  }
}
