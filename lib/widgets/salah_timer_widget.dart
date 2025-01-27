import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/salah_times.dart';
import '../providers/salah_time_provider.dart';

class SalahTimeWidget extends ConsumerStatefulWidget {
  final List<String> salahList;

  const SalahTimeWidget(this.salahList, {super.key});

  @override
  SalahTimeWidgetState createState() => SalahTimeWidgetState();
}

class SalahTimeWidgetState extends ConsumerState<SalahTimeWidget> {
  late Timer _timer;
  Duration _timeUntilNextSalah = const Duration();
  int nextSalahIndex = -1;

  @override
  void initState() {
    super.initState();
    _updateTimeUntilNextSalah();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTimeUntilNextSalah();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTimeUntilNextSalah() {
    DateTime now = DateTime.now();
    String? nextTimeSlot = findNextTimeSlot(now, widget.salahList);

    if (nextTimeSlot != null) {
      DateTime nextTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(nextTimeSlot.split(':')[0]),
        int.parse(nextTimeSlot.split(':')[1]),
      );
      setState(() {
        _timeUntilNextSalah = nextTime.difference(now);
      });
    } else {
      int hour = int.parse(widget.salahList[0].split(':')[0]);
      int minute = int.parse(widget.salahList[0].split(':')[1]);
      DateTime now = DateTime.now();
      DateTime tomorrow = DateTime(now.year, now.month, now.day + 1, hour, minute);
      Duration difference = tomorrow.difference(now); // Zaman farkını hesapla

      setState(() {
        nextSalahIndex = -1;
        _timeUntilNextSalah = difference;
      });
    }
    if (_timeUntilNextSalah.inHours == 0 &&
        _timeUntilNextSalah.inMinutes.remainder(60) == 0 &&
        _timeUntilNextSalah.inSeconds.remainder(60) == 0) {
      ref.watch(cityProvider.notifier).setIsTimeOfEzan = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    int hours = _timeUntilNextSalah.inHours;
    int minutes = _timeUntilNextSalah.inMinutes.remainder(60);
    int seconds = _timeUntilNextSalah.inSeconds.remainder(60);
    String formattedTime =
        '${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
    List<String> salahTimesName = [
      SalahTimeTypes.fajr,
      SalahTimeTypes.sunrise,
      SalahTimeTypes.dhuhr,
      SalahTimeTypes.asr,
      SalahTimeTypes.maghrib,
      SalahTimeTypes.isha,
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          nextSalahIndex != -1
              ? "${salahTimesName[nextSalahIndex]} Vaktinin Girmesine Kalan Süre"
              : '${salahTimesName[0]} Vaktinin Girmesine Kalan Süre',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 5),
        Text(
          formattedTime,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 30, fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String? findNextTimeSlot(DateTime now, List<String> timeSlots) {
    String? nextTimeSlot;
    for (String timeSlot in timeSlots) {
      int hour = int.parse(timeSlot.split(':')[0]);
      int minute = int.parse(timeSlot.split(':')[1]);

      DateTime timeSlotDateTime = DateTime(now.year, now.month, now.day, hour, minute);

      if (timeSlotDateTime.isAfter(now)) {
        nextTimeSlot = timeSlot;
        nextSalahIndex = timeSlots.indexOf(timeSlot);

        break;
      }
    }
    return nextTimeSlot;
  }
}
