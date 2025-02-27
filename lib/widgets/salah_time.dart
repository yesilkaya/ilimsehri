import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/color_styles.dart';
import '../constant/constants.dart';
import '../constant/salah_times.dart';
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(Constants.miladiTakvimGetir(), style: Theme.of(context).textTheme.bodyLarge),
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
                          state.cities != null && state.selectedCity!.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      right: defaultPadding,
                                      left: defaultPadding,
                                      top: defaultPadding / 2,
                                      bottom: defaultPadding / 2),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _salahTimeWidget([SalahTimeTypes.fajr, state.fajr ?? '']),
                                      _getVerticalDivider(),
                                      _salahTimeWidget([SalahTimeTypes.sunrise, state.sunrise ?? '']),
                                      _getVerticalDivider(),
                                      _salahTimeWidget([SalahTimeTypes.dhuhr, state.dhuhr ?? '']),
                                      _getVerticalDivider(),
                                      _salahTimeWidget([SalahTimeTypes.asr, state.asr ?? '']),
                                      _getVerticalDivider(),
                                      _salahTimeWidget([SalahTimeTypes.maghrib, state.maghrib ?? '']),
                                      _getVerticalDivider(),
                                      _salahTimeWidget([SalahTimeTypes.isha, state.isha ?? '']),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      )),
                  /*state.isTimeOfEzan
                      ? const AudioPlayerWidget(
                          soundPath: 'ezan_1.mp3',
                          isReverseColor: true,
                        )
                      : Container(),

                   */
                ],
              ),
            ],
          )
        : Container();
  }

  Widget _getVerticalDivider() => SizedBox(height: 35, child: VerticalDivider(color: Colors.grey.shade700));

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
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
                    )
                  : Container(),
            ],
          )
        : Container();
  }
}
