import 'package:flutter/material.dart';
import 'package:ilimsehri/constant/color_styles.dart';

import '../constant/constants.dart';
import '../view/models/fatima_alidir.dart';

class FatimaAlidirDetailWidget extends StatefulWidget {
  final List<FatimaAlidir> events;

  const FatimaAlidirDetailWidget({
    super.key,
    required this.events,
  });

  @override
  State<FatimaAlidirDetailWidget> createState() => _FatimaAlidirDetailWidgetState();
}

class _FatimaAlidirDetailWidgetState extends State<FatimaAlidirDetailWidget> {
  late final List<int> randomIndexes;
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    randomIndexes = _generateSequentialIndexes(widget.events.length);
  }

  List<int> _generateSequentialIndexes(int count) {
    return List.generate(count, (index) => index);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: ColorStyles.appTextColor),
        ),
        actions: [
          IconButton(
            color: ColorStyles.appTextColor,
            icon: const Icon(Icons.info),
            onPressed: () => showGaybinDiliDialog(context),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/fatima_ali.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: size.height,
            color: Colors.black.withOpacity(0.8),
          ),
          Column(
            children: [
              const SizedBox(height: 100),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: randomIndexes.length,
                  onPageChanged: (index) {
                    setState(() => currentIndex = index);
                    _scrollToActiveDot();
                    _scrollToCenterDot();
                  },
                  itemBuilder: (context, pageIndex) {
                    final event = widget.events[randomIndexes[pageIndex]];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${currentIndex + 1}. ${event.title}',
                                style: const TextStyle(
                                  color: ColorStyles.appTextColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(height: 10),
                            Text(
                              event.description,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Dot indikatör
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(randomIndexes.length, (index) {
                      bool isActive = index == currentIndex;
                      return GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          setState(() => currentIndex = index);
                          _scrollToActiveDot();
                          _scrollToCenterDot();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 20 : 16,
                          height: isActive ? 20 : 16,
                          decoration: BoxDecoration(
                            color: isActive ? Colors.white : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: isActive ? Colors.black : Colors.black,
                                fontSize: isActive ? 12 : 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _scrollToCenterDot() {
    // her dot'un genişliği + margin (tahmini 16px)
    double dotWidth = 24;
    double screenWidth = MediaQuery.of(context).size.width;

    double targetOffset = (currentIndex * dotWidth) - (screenWidth / 2) + (dotWidth / 2);

    _scrollController.animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToActiveDot() {
    double targetOffset = currentIndex * 24.0; // Tahmini bir offset: 12 + 4+4 margin
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void showGaybinDiliDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: ColorStyles.textBackRoundColor,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dialog Title
                const Row(
                  children: [
                    Icon(Icons.book, color: ColorStyles.appBackGroundColor, size: 22),
                    SizedBox(width: 10),
                    Text(
                      "Fatıma Ali'dir",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorStyles.appBackGroundColor),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Constants.fatimaAlidirDesc,
                          style: const TextStyle(color: ColorStyles.appBackGroundColor, fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorStyles.appBackGroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Kapat", style: TextStyle(color: ColorStyles.appTextColor, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
