import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final vibrationProvider = StateNotifierProvider<VibrationNotifier, bool>((ref) {
  return VibrationNotifier();
});

class VibrationNotifier extends StateNotifier<bool> {
  VibrationNotifier() : super(false) {
    _loadVibration();
  }

  Future<void> _loadVibration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool vibration = prefs.getBool('vibration') ?? false;
    state = vibration;
  }

  Future<void> setVibration(bool vibration) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('vibration', vibration);
    state = vibration;
  }
}
