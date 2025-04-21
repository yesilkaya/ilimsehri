import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/color_styles.dart';
import '../constant/constants.dart';
import '../constant/salah_times.dart';
import '../helper/time_helper.dart';
import '../providers/salah_time_provider.dart';
import 'salah_timer_widget.dart';

class SalahTime extends ConsumerStatefulWidget {
  const SalahTime({super.key});

  @override
  ConsumerState<SalahTime> createState() => _SliderAndSalahTimeState();
}

class _SliderAndSalahTimeState extends ConsumerState<SalahTime> {
  @override
  void initState() {
    ref.read(cityProvider.notifier).init(ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cityProvider);

    return state.isPageReady
        ? Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 6, right: 6, top: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ColorStyles.appTextColor, style: BorderStyle.solid),
                        color: ColorStyles.appBackGroundColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(Constants.miladiTakvimGetir(), style: Theme.of(context).textTheme.bodyLarge),
                                const Text('  -  '),
                                Text(
                                  Constants.hicriTakvimGetir(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          SalahTimeWidget([
                            state.fajr!,
                            state.sunrise!,
                            state.dhuhr!,
                            state.asr!,
                            state.maghrib!,
                            state.isha!,
                          ]),
                          state.cities != null &&
                                  state.selectedCity!.isNotEmpty &&
                                  state.countries != null &&
                                  state.selectedCountry!.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      right: defaultPadding / 2,
                                      left: defaultPadding / 2,
                                      top: defaultPadding / 2,
                                      bottom: defaultPadding / 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if (state.fajr != null && state.fajr!.isNotEmpty)
                                        _salahTimeWidget(
                                            [SalahTimeTypes.imsak, _getZeynebiyeImsakSalahTime(state.fajr!)]),
                                      if (state.fajr != null && state.fajr!.isNotEmpty) _getVerticalDivider(),
                                      if (state.fajr != null && state.fajr!.isNotEmpty)
                                        _salahTimeWidget([SalahTimeTypes.fajr, state.fajr ?? '']),
                                      if (state.fajr != null && state.fajr!.isNotEmpty) _getVerticalDivider(),
                                      if (state.sunrise != null && state.sunrise!.isNotEmpty)
                                        _salahTimeWidget([SalahTimeTypes.sunrise, state.sunrise ?? '']),
                                      if (state.sunrise != null && state.sunrise!.isNotEmpty) _getVerticalDivider(),
                                      if (state.dhuhr != null && state.dhuhr!.isNotEmpty)
                                        _salahTimeWidget([SalahTimeTypes.dhuhr, state.dhuhr ?? '']),
                                      if (state.dhuhr != null && state.dhuhr!.isNotEmpty) _getVerticalDivider(),
                                      if (state.asr != null && state.asr!.isNotEmpty)
                                        _salahTimeWidget([SalahTimeTypes.asr, state.asr ?? '']),
                                      if (state.asr != null && state.asr!.isNotEmpty) _getVerticalDivider(),
                                      if (state.maghrib != null && state.maghrib!.isNotEmpty)
                                        _salahTimeWidget([SalahTimeTypes.maghrib, state.maghrib ?? '']),
                                      if (state.maghrib != null && state.maghrib!.isNotEmpty) _getVerticalDivider(),
                                      if (state.isha != null && state.isha!.isNotEmpty)
                                        _salahTimeWidget([SalahTimeTypes.isha, state.isha ?? '']),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      )),
                ],
              ),
              TimeHelper.checkDate()
                  ? Positioned(
                      top: 12,
                      right: 6,
                      child: IconButton(
                        color: Colors.grey,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 7),
                            backgroundColor: ColorStyles.appTextColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: const Center(
                              child: Text(
                                "Ramazan ayı başlangıcı taklit ettiğiniz müçtehidin fetvasına göre farklılık gösterebilir.",
                                style: TextStyle(color: ColorStyles.appBackGroundColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ));
                        },
                        icon: const Icon(Icons.info_outline),
                      ))
                  : Container(),
            ],
          )
        : Container();
  }

  Widget _getVerticalDivider() => Container(
        height: 35,
        width: 1,
        color: Colors.grey.shade700,
        margin: const EdgeInsets.symmetric(horizontal: 2),
      );

  Widget _salahTimeWidget(List<String> salah) {
    return salah.isNotEmpty
        ? Column(
            children: [
              Text(
                salah[0],
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 11),
              ),
              salah.length == 2
                  ? Text(
                      salah[1],
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
                    )
                  : Container(),
            ],
          )
        : Container();
  }

  String _getZeynebiyeImsakSalahTime(String timings) {
    if (timings.isEmpty) return '';
    List<String> timePartsFajr = timings.split(':');
    int hour = int.parse(timePartsFajr[0]);
    int minute = int.parse(timePartsFajr[1]);
    DateTime initialTimeFajr = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour, minute);
    DateTime newTimeFajr = initialTimeFajr.subtract(const Duration(minutes: 25));
    String newTimeString =
        '${newTimeFajr.hour.toString().padLeft(2, '0')}:${newTimeFajr.minute.toString().padLeft(2, '0')}';
    return newTimeString;
  }
}
