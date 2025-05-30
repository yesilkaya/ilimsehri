import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/color_styles.dart';
import '../../constant/salah_times.dart';
import '../../helper/countries.dart';
import '../../helper/notify_helper.dart';
import '../../providers/font_size_provider.dart';
import '../../providers/salah_time_provider.dart';
import '../../providers/vibration_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends ConsumerState<SettingsScreen> {
  String defaultCountry = 'Turkey';
  String defaultCity = 'İstanbul';
  bool _fajrNotification = true;
  bool _dhuhrNotification = true;
  bool _asrNotification = true;
  bool _maghribNotification = true;
  bool _ishaNotification = true;

  @override
  void initState() {
    super.initState();
    _loadSelectedCity();
    if (Platform.isIOS) _loadNotificationSettings(); // Bildirim ayarlarını yükle
    ref.read(cityProvider.notifier).init(ref);
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = ref.watch(fontSizeProvider);
    final state = ref.watch(cityProvider);
    double currentFontSize = ref.watch(fontSizeProvider) ?? 16.0;
    bool isVibrationActive = ref.watch(vibrationProvider) ?? false;

    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      appBar: AppBar(
        backgroundColor: ColorStyles.appBackGroundColor,
        titleTextStyle: const TextStyle(color: ColorStyles.appTextColor),
        title: Text(
          'Ayarlar',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: ColorStyles.appTextColor, fontSize: fontSize + 4),
        ),
        leading: const BackButton(color: ColorStyles.appTextColor),
      ),
      body: state.isPageReady
          ? Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 34.0, top: 20),
                      child:
                          Text('Font Büyüklüğü', style: TextStyle(fontSize: fontSize, color: ColorStyles.appTextColor)),
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        valueIndicatorTextStyle: TextStyle(
                            color: ColorStyles.appBackGroundColor, fontSize: fontSize), // Change the label color here
                      ),
                      child: Slider(
                        value: currentFontSize.toDouble(),
                        min: 10,
                        max: 25,
                        divisions: 15,
                        activeColor: ColorStyles.appTextColor,
                        inactiveColor: Color.lerp(ColorStyles.appTextColor, Colors.white, 0.5),
                        label: currentFontSize.toString(),
                        onChanged: (newSize) {
                          ref.read(fontSizeProvider.notifier).setFontSize(newSize);
                        },
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: SettingsList(
                    brightness: Brightness.dark,
                    lightTheme: SettingsThemeData(
                      dividerColor: ColorStyles.appBackGroundColor,
                      settingsListBackground: ColorStyles.appBackGroundColor,
                      settingsSectionBackground: Color.lerp(ColorStyles.appTextColor, Colors.white, 0.5),
                      titleTextColor: ColorStyles.appTextColor,
                      leadingIconsColor: ColorStyles.appBackGroundColor,
                      inactiveTitleColor: Colors.red,
                    ),
                    sections: [
                      SettingsSection(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text('Zikirmatik Titreşimi', style: TextStyle(fontSize: fontSize)),
                        ),
                        tiles: [
                          SettingsTile.switchTile(
                            title: Text(
                              isVibrationActive ? 'Açık' : 'Kapalı',
                              style: TextStyle(color: ColorStyles.appBackGroundColor, fontSize: fontSize),
                            ),
                            leading: const Icon(Icons.vibration),
                            initialValue: isVibrationActive,
                            onToggle: (bool value) {
                              ref.read(vibrationProvider.notifier).setVibration(value);
                            },
                            activeSwitchColor: ColorStyles.appBackGroundColor,
                          ),
                        ],
                      ),
                      SettingsSection(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text('Ülke', style: TextStyle(fontSize: fontSize)),
                        ),
                        tiles: [
                          SettingsTile.navigation(
                            title: Text(
                              getKeyFromValue(Countries.countryMap, state.selectedCountry) ?? 'Ülke Seçin',
                              style: TextStyle(color: ColorStyles.appBackGroundColor, fontSize: fontSize),
                            ),
                            leading: const Icon(Icons.location_on_outlined),
                            onPressed: (context) {
                              _showCountrySelectionSheet(context);
                            },
                          ),
                        ],
                      ),
                      SettingsSection(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text('Şehir', style: TextStyle(fontSize: fontSize)),
                        ),
                        tiles: [
                          SettingsTile.navigation(
                            title: Text(
                              state.selectedCity != null && state.selectedCity!.isNotEmpty
                                  ? state.selectedCity!
                                  : 'Şehir Seçin',
                              style: TextStyle(color: ColorStyles.appBackGroundColor, fontSize: fontSize),
                            ),
                            leading: const Icon(Icons.location_on_outlined),
                            onPressed: (context) {
                              _showCitySelectionSheet(context, state.cities);
                            },
                          ),
                        ],
                      ),
                      if (Platform.isIOS && state.selectedCity != null)
                        SettingsSection(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text('Namaz Vakti Bildirimleri', style: TextStyle(fontSize: fontSize)),
                          ),
                          tiles: [
                            _buildSwitchTile(
                              SalahTimeTypes.fajr,
                              _fajrNotification,
                              CupertinoIcons.sunrise_fill,
                              (value) {
                                setState(() {
                                  _fajrNotification = value;
                                });
                                _saveNotificationSettings(SalahTimesNotification.fajr, _fajrNotification);
                              },
                              fontSize,
                            ),
                            _buildSwitchTile(
                              SalahTimeTypes.dhuhr,
                              _dhuhrNotification,
                              CupertinoIcons.sun_max_fill,
                              (value) {
                                setState(() {
                                  _dhuhrNotification = value;
                                });
                                _saveNotificationSettings(SalahTimesNotification.dhuhr, _dhuhrNotification);
                              },
                              fontSize,
                            ),
                            _buildSwitchTile(
                              SalahTimeTypes.asr,
                              _asrNotification,
                              CupertinoIcons.sun_haze_fill,
                              (value) {
                                setState(() {
                                  _asrNotification = value;
                                });
                                _saveNotificationSettings(SalahTimesNotification.asr, _asrNotification);
                              },
                              fontSize,
                            ),
                            _buildSwitchTile(
                              SalahTimeTypes.maghrib,
                              _maghribNotification,
                              CupertinoIcons.sunset_fill,
                              (value) {
                                setState(() {
                                  _maghribNotification = value;
                                });
                                _saveNotificationSettings(SalahTimesNotification.maghrib, _maghribNotification);
                              },
                              fontSize,
                            ),
                            _buildSwitchTile(
                              SalahTimeTypes.isha,
                              _ishaNotification,
                              CupertinoIcons.moon_stars_fill,
                              (value) {
                                setState(() {
                                  _ishaNotification = value;
                                });
                                _saveNotificationSettings(SalahTimesNotification.isha, _ishaNotification);
                              },
                              fontSize,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _loadSelectedCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedCity = prefs.getString('selectedCity');
    ref.read(cityProvider.notifier).setSelectedCity = cachedCity;
  }

  Future<void> _loadNotificationSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fajrNotification = prefs.getBool(SalahTimesNotification.fajr) ?? false;
    _dhuhrNotification = prefs.getBool(SalahTimesNotification.dhuhr) ?? false;
    _asrNotification = prefs.getBool(SalahTimesNotification.asr) ?? false;
    _maghribNotification = prefs.getBool(SalahTimesNotification.maghrib) ?? false;
    _ishaNotification = prefs.getBool(SalahTimesNotification.isha) ?? false;
    setState(() {});
  }

  Future<void> _saveSelectedCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCity', city);
  }

  Future<void> _saveSelectedCountry(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCountry', city);
  }

  Future<void> _saveNotificationSettings(String salahTimeNotificationName, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(salahTimeNotificationName, value);
    final notifier = ref.read(cityProvider.notifier);
    final state = ref.read(cityProvider);
    notifier.fetchSalahTimes7Days(
        state.selectedCountry ?? defaultCountry, state.selectedCity ?? defaultCity, salahTimeNotificationName);
  }

  AbstractSettingsTile _buildSwitchTile(
      String title, bool value, IconData icon, ValueChanged<bool> onChanged, double fontSize) {
    return SettingsTile.switchTile(
      title: Text(
        title,
        style: TextStyle(fontSize: fontSize),
      ),
      leading: Icon(icon),
      initialValue: value,
      onToggle: onChanged,
      activeSwitchColor: ColorStyles.appBackGroundColor,
    );
  }

  void _showCitySelectionSheet(BuildContext context, List<String>? cities) {
    final state = ref.read(cityProvider);
    final fontSize = ref.watch(fontSizeProvider);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                decoration: const BoxDecoration(
                  color: ColorStyles.appBackGroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 2,
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      decoration: BoxDecoration(
                        color: ColorStyles.appTextColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: double.infinity,
                      color: Color.lerp(ColorStyles.appBackGroundColor, Colors.white, 0.2),
                      child: Center(
                        child: Text(
                          'Şehir Seçin',
                          style: TextStyle(
                              fontSize: fontSize, fontWeight: FontWeight.bold, color: ColorStyles.appTextColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cities?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              String city = state.cities?[index] ?? '';
                              return ListTile(
                                title:
                                    Center(child: Text(city, style: const TextStyle(color: ColorStyles.appTextColor))),
                                visualDensity: VisualDensity.compact,
                                onTap: () async {
                                  final notifier = ref.read(cityProvider.notifier);
                                  final state = ref.watch(cityProvider);
                                  notifier.setSelectedCity = city;
                                  if (state.selectedCountry != null && state.selectedCity != null) {
                                    await notifier.fetchPrayerTimes(state.selectedCountry!, city);
                                    if (_fajrNotification ||
                                        _dhuhrNotification ||
                                        _asrNotification ||
                                        _maghribNotification ||
                                        _ishaNotification) {
                                      await LocalNotificationService.cancelAllNotifications();
                                      for (int i = 0; i < SalahTimesNotification.all.length; i++) {
                                        notifier.fetchSalahTimes7Days(state.selectedCountry ?? defaultCountry, city,
                                            SalahTimesNotification.all[i]);
                                      }
                                    }
                                  }
                                  _saveSelectedCity(city);
                                  if (context.mounted) Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String? getKeyFromValue(Map<String, String> map, String? value) {
    return map.entries.firstWhere((element) => element.value == value, orElse: () => const MapEntry('', '')).key.isEmpty
        ? null
        : map.entries.firstWhere((element) => element.value == value).key;
  }

  void _showCountrySelectionSheet(BuildContext context) {
    final fontSize = ref.watch(fontSizeProvider);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                decoration: const BoxDecoration(
                  color: ColorStyles.appBackGroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 2,
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      decoration: BoxDecoration(
                        color: ColorStyles.appTextColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: double.infinity,
                      color: Color.lerp(ColorStyles.appBackGroundColor, Colors.white, 0.2),
                      child: Center(
                        child: Text(
                          'Ülke Seçin',
                          style: TextStyle(
                              fontSize: fontSize, fontWeight: FontWeight.bold, color: ColorStyles.appTextColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: Countries.countryMap.length,
                            itemBuilder: (BuildContext context, int index) {
                              final turkishCountry = Countries.countryMap.keys.elementAt(index);
                              final englishCountry = Countries.countryMap[turkishCountry]!;

                              return ListTile(
                                title: Center(
                                  child: Text(
                                    turkishCountry,
                                    style: const TextStyle(color: ColorStyles.appTextColor),
                                  ),
                                ),
                                visualDensity: VisualDensity.compact,
                                onTap: () async {
                                  final notifier = ref.read(cityProvider.notifier);
                                  notifier.setSelectedCountry = englishCountry; // İngilizcesini kaydet
                                  await notifier.fetchCities();
                                  notifier.setSelectedCity = '';
                                  _saveSelectedCountry(englishCountry); // İngilizcesini sakla
                                  if (context.mounted) Navigator.pop(context);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
