import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constant/color_styles.dart';
import '../constant/constants.dart';
import '../providers/ayet_hadis_provider.dart';
import '../providers/salah_time_provider.dart';
import '../view/screens/settings_screen.dart';
import 'dot_indicators.dart';

class CarouselSliderWidget extends ConsumerStatefulWidget {
  const CarouselSliderWidget({super.key});

  @override
  CarouselSliderWidgetState createState() => CarouselSliderWidgetState();
}

class CarouselSliderWidgetState extends ConsumerState<CarouselSliderWidget> {
  int _selectedIndex = 0;
  late PageController _pageController;
  late Timer _timer;
  List<Shadow> textShadow = [
    const Shadow(
        offset: Offset(2.0, 2.0), // Gölgenin konumu
        blurRadius: 6.0, // Gölgenin bulanıklık derecesi
        color: Colors.black),
    const Shadow(
        offset: Offset(-2.0, -2.0), // Gölgenin konumu
        blurRadius: 6.0, // Gölgenin bulanıklık derecesi
        color: Colors.black),
  ];

  @override
  void initState() {
    super.initState();

    final notifier = ref.read(ayethadisProvider.notifier);
    notifier.init();
    _pageController = PageController(initialPage: 0);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(seconds: 15), (Timer timer) {
        if (_selectedIndex < notifier.getBannersLength() - 1) {
          _selectedIndex++;
        } else {
          _selectedIndex = 0;
        }

        _pageController.animateToPage(
          _selectedIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
        );
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ayethadisProvider);
    final stateCity = ref.watch(cityProvider);

    return (state.isPageReady)
        ? state.banners!.isNotEmpty
            ? AspectRatio(
                aspectRatio: 1.87,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: state.banners?.length ?? 0,
                      onPageChanged: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      itemBuilder: (context, index) => state.banners?[index],
                    ),
                    FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: SizedBox(
                          height: 16,
                          child: Row(
                            children: List.generate(
                              state.banners?.length ?? 0,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: defaultPadding / 4),
                                  child: DotIndicator(
                                    isActive: index == _selectedIndex,
                                    activeColor: Colors.white,
                                    inActiveColor: Colors.white54,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        child: Row(
                          children: [
                            Text(
                              stateCity.selectedCity ?? '',
                              style: TextStyle(color: ColorStyles.textWhite, shadows: textShadow, fontSize: 16),
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.settings, color: ColorStyles.textWhite, size: 22),
                          ],
                        ),
                        onTap: () =>
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
                      ),
                    ),
                  ],
                ))
            : Container()
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
