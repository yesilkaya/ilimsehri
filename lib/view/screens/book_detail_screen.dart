import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/color_styles.dart';
import '../../constant/constants.dart';
import '../../constant/route_constants.dart';
import '../../helper/platform_helper.dart';
import '../../helper/url_launcher_helper.dart';
import '../../helper/whatsAppHelper.dart';
import '../../providers/api_provider_ehlibeyt.dart';
import '../models/book_model.dart';
import '../models/category.dart';
import '../models/question.dart';
import 'quiz_screen.dart';

class SelectedBookScreen extends StatefulWidget {
  final BookModel selectedBook;

  const SelectedBookScreen({super.key, required this.selectedBook});

  @override
  State<SelectedBookScreen> createState() => SelectedBookScreenState();
}

class SelectedBookScreenState extends State<SelectedBookScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? text;
  bool showQuiz = false;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _onTabChanged(_tabController.index);
      }
    });

    showQuiz = masumlarBookList.indexWhere(
            (element) => element.name == widget.selectedBook.name && element.writer == widget.selectedBook.writer) !=
        -1;

    super.initState();
  }

  void _onTabChanged(int index) {
    setState(() {
      text = index == 0
          ? null
          : index == 1
              ? widget.selectedBook.name
              : widget.selectedBook.writer;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int index = masumlarBookList.indexWhere(
        (element) => element.name == widget.selectedBook.name && element.writer == widget.selectedBook.writer);
    if (index == -1) {
      index = peygamberlerBookList.indexWhere(
          (element) => element.name == widget.selectedBook.name && element.writer == widget.selectedBook.writer);
    }

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showQuiz)
            SizedBox(
              height: 30,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  List<Question> questions = await getQuestions(categories[index]);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              QuizScreen(questions: questions, category: categories[index], numberOfQuestion: 10)));
                },
                backgroundColor: ColorStyles.appTextColor,
                label: const Row(
                  children: [
                    Text('Bilgi Yarışması', style: TextStyle(fontSize: 16)),
                    SizedBox(width: 10),
                    Icon(
                      Icons.quiz_outlined,
                      color: ColorStyles.appBackGroundColor,
                      size: 18,
                    ),
                  ],
                ),
                heroTag: '1',
              ),
            ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            child: FloatingActionButton.extended(
              onPressed: () async {
                String contact = '+905523465337';

                if (await WhatsAppHelper.isWhatsAppInstalled(Routes.whatsappUrl(contact))) {
                  await launchUrl(Uri.parse(Routes.whatsappUrl(contact)));
                } else {
                  UrlLauncherHelper.openUrl(
                      PlatformHelper.isIos ? Routes.appStoreWhatsappUrl : Routes.playStoreWhatsappUrl);
                }
              },
              backgroundColor: ColorStyles.appTextColor,
              label: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Sipariş Hattı', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    whatsAppSvgPath,
                    width: 22,
                    colorFilter: ColorFilter.mode(Colors.green.shade800, BlendMode.srcIn),
                  ),
                ],
              ),
              heroTag: '2',
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: const BackButton(color: ColorStyles.appTextColor),
              backgroundColor: ColorStyles.appBackGroundColor,
              expandedHeight: MediaQuery.of(context).size.height * 0.40,
              flexibleSpace: Container(
                color: ColorStyles.appBackGroundColor,
                height: MediaQuery.of(context).size.height * 0.40,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.40,
                    margin: const EdgeInsets.only(top: 50, bottom: 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20), // Burada radius ekliyoruz
                      child: Image.asset(
                        widget.selectedBook.image.contains('masumlar') ||
                                widget.selectedBook.image.contains('peygamberler')
                            ? '${widget.selectedBook.image}${index + 1}.jpeg'
                            : widget.selectedBook.image,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25),
                child: Text(
                  widget.selectedBook.name,
                  style: GoogleFonts.lora(fontSize: 17, color: ColorStyles.appTextColor, fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 25),
                    child: Text(
                      'Yazar: ${widget.selectedBook.writer}',
                      style: GoogleFonts.openSans(
                          fontSize: 13, color: ColorStyles.kGreyColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 25),
                    child: Text(
                      widget.selectedBook.size != null ? 'Ölçü: ${widget.selectedBook.size}' : '',
                      style: GoogleFonts.openSans(
                          fontSize: 12, color: ColorStyles.kGreyColor, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 25),
                    child: Text(
                      widget.selectedBook.drawer != null ? 'Resim: ${widget.selectedBook.drawer ?? ''}' : '',
                      style: GoogleFonts.openSans(
                          fontSize: 13, color: ColorStyles.kGreyColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 25),
                    child: Text(
                      widget.selectedBook.pageNumber != null ? '${widget.selectedBook.pageNumber}' : '',
                      style: GoogleFonts.openSans(
                          fontSize: 12, color: ColorStyles.kGreyColor, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, left: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 3),
                    widget.selectedBook.priceAfetDiscount != null
                        ? Row(
                            children: [
                              Text(
                                "\₺${widget.selectedBook.priceAfetDiscount}",
                                style: const TextStyle(
                                  color: ColorStyles.appTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "\₺${widget.selectedBook.price}",
                                style: TextStyle(
                                    color: Theme.of(context).textTheme.bodyMedium?.color,
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 3,
                                    decorationColor: ColorStyles.appTextColor.withOpacity(.4)),
                              ),
                            ],
                          )
                        : Text(
                            "\₺${widget.selectedBook.price}",
                            style: const TextStyle(
                              color: Color(0xFF31B0D8),
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                height: 60,
                margin: const EdgeInsets.only(top: 23, bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TabBar(
                        controller: _tabController, // Kontrolcüyü buraya ekleyin
                        isScrollable: false, // Eşit genişlikte tablar için
                        labelPadding: const EdgeInsets.all(0),
                        labelColor: ColorStyles.appTextColor, // Seçilen tabın metin rengi kırmızı
                        unselectedLabelColor: ColorStyles.kGreyColor,
                        labelStyle: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w700),
                        unselectedLabelStyle: GoogleFonts.openSans(fontSize: 14, fontWeight: FontWeight.w600),
                        tabs: [
                          Tab(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Center(child: Text('Açıklama')),
                            ),
                          ),
                          Tab(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Center(child: Text('Benzer Kitaplar', textAlign: TextAlign.center)),
                            ),
                          ),
                          Tab(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Center(child: Text('Yazar')),
                            ),
                          ),
                        ],
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorStyles.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                child: Text(
                  text ?? widget.selectedBook.description ?? 'Detaylı bilgi için lütfen iletişime geçiniz.',
                  style: GoogleFonts.openSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorStyles.kGreyColor,
                    letterSpacing: 1.5,
                    height: 2,
                  ),
                ),
              )
            ]))
          ],
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    this.leading,
    required this.text,
  });

  final VoidCallback onPressed; // This callback does not return any value
  final Widget? leading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 75, right: 75, bottom: 15),
      color: Colors.transparent,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          backgroundColor: ColorStyles.appTextColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading ?? Container(),
            const SizedBox(width: 15),
            Text(
              text,
              style: GoogleFonts.lora(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: ColorStyles.appBackGroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
