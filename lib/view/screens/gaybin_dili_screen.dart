import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/color_styles.dart';
import '../../constant/poems.dart';
import '../../widgets/network_image_with_loader.dart';

class GaybinDiliScreen extends StatefulWidget {
  const GaybinDiliScreen({super.key});

  @override
  State<GaybinDiliScreen> createState() => GaybinDiliScreenState();
}

class GaybinDiliScreenState extends State<GaybinDiliScreen> {
  bool isShowCard = true;
  bool isShowButton = true;
  int backCardNumber = Random().nextInt(10);
  int frontCardNumber = Random().nextInt(gaybinDiliImages.length - 1) + 1;
  String currentDayNumber = DateFormat('yyyyMMdd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _checkDayNumber();
  }

  Future<void> _checkDayNumber() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedDayNumber = prefs.getString('dayNumber');
    if (savedDayNumber != null && savedDayNumber == currentDayNumber) {
      setState(() {
        isShowCard = false;
      });
    } else {
      setState(() {
        isShowCard = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      appBar: AppBar(
        title: Text(
          "Gayb'ın Dili",
          style: GoogleFonts.dancingScript(textStyle: const TextStyle(fontSize: 30, color: ColorStyles.appTextColor)),
        ),
        centerTitle: true,
        backgroundColor: ColorStyles.appBackGroundColor,
        leading: const BackButton(color: ColorStyles.appTextColor),
        actions: [
          IconButton(
            color: ColorStyles.appTextColor,
            icon: const Icon(Icons.info),
            onPressed: () => showGaybinDiliDialog(context),
          ),
        ],
      ),
      body: isShowCard == true
          ? _renderContent(context)
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text('Niyet Kartı Hakkınız Her Gün Bir Adet ile Sınırlıdır. \n\n\n Yarın Yine Bekleriz.',
                    textAlign: TextAlign.center,
                    style:
                        GoogleFonts.dancingScript(textStyle: const TextStyle(fontSize: 22, color: ColorStyles.sepya))),
              ),
            ),
    );
  }

  Widget _renderContent(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String imagePathFront = 'assets/img/hafiz/$frontCardNumber.jpeg';

    return Column(
      children: [
        Container(
          height: height - height / 3.5,
          width: width - 40,
          margin: const EdgeInsets.only(right: 20.0, left: 20, top: 40.0),
          child: Card(
            elevation: 0.0,
            color: ColorStyles.appBackGroundColor,
            child: FlipCard(
              direction: FlipDirection.HORIZONTAL,
              side: CardSide.FRONT,
              onFlipDone: (status) async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('dayNumber', currentDayNumber);
                if (isShowButton == true) {
                  setState(() {
                    isShowButton = false;
                  });
                }
              },
              speed: 2500,
              front: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorStyles.sepya,
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                  color: ColorStyles.appTextColor,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: NetworkImageWithLoader(gaybinDiliImages[frontCardNumber], radius: 30),
              ),
              back: Container(
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: ColorStyles.sepya, spreadRadius: 1, blurRadius: 10)],
                  color: ColorStyles.sepya,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: LocalImageWithLoader(
                  imagePathFront,
                  radius: 30,
                  widget: BackWidget(cardNumber: backCardNumber),
                ),
              ),
            ),
          ),
        ),
        if (isShowButton)
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 25),
            height: 36,
            width: 150,
            color: Colors.transparent,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.lerp(ColorStyles.appBackGroundColor, Colors.white, 0.1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onPressed: () {
                setState(() {
                  frontCardNumber = Random().nextInt(gaybinDiliImages.length - 1) + 1;
                });
              },
              child: Text(
                'Kart Değiştir',
                style: GoogleFonts.dancingScript(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: ColorStyles.appTextColor,
                ),
              ),
            ),
          ),
      ],
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
                      "Gayb'ın Dili",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorStyles.appBackGroundColor),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hafız Şirazi’nin Divanından Niyet Kartları",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14, color: ColorStyles.appBackGroundColor),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Hafız-ı Şirazi’nin şiirlerinden ilham alan bu uygulama, tamamen kültürel bir deneyim olarak tasarlanmıştır ve hiçbir dini veya manevi dayanak taşımamaktadır. \nİran kültüründe Hafız’ın dizelerinden niyet tutma geleneği, sadece edebiyatın ve şiirin derin anlamlarına duyulan hayranlıkla yaşatılan bir ritüeldir. Uygulamamız, bu geleneği modern bir dokunuşla sunarak, Hafız’ın zamansız dizelerini hayatınıza ilham ve estetik bir deneyim olarak katmayı amaçlar. Bu kartları dini bir inanış değil, edebiyatla kurulan kültürel bir bağ olarak görebilir; Hafız’ın şiirleriyle ilham dolu bir yolculuğa çıkabilirsiniz.",
                          style: TextStyle(fontSize: 12, color: ColorStyles.appBackGroundColor, height: 1.5),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Niyet Kartları Nasıl Kullanılır?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14, color: ColorStyles.appBackGroundColor),
                        ),
                        SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            text: '• Samimi Bir Niyet: ',
                            style: TextStyle(fontWeight: FontWeight.bold, color: ColorStyles.appBackGroundColor),
                            children: [
                              TextSpan(
                                text:
                                    'Kart seçmeden önce, zihninizde belirli bir soru ya da sorun belirleyin ve bu niyet üzerine düşünün.\n',
                                style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: '• Kart Seçimi: ',
                            style: TextStyle(fontWeight: FontWeight.bold, color: ColorStyles.appBackGroundColor),
                            children: [
                              TextSpan(
                                text: 'Niyetinize uygun bir kart seçin.\n',
                                style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: '• Yorum: ', // İlk kısım normal
                            style: TextStyle(fontWeight: FontWeight.bold, color: ColorStyles.appBackGroundColor),
                            children: [
                              TextSpan(
                                text:
                                    'Gazeli okuduktan sonra, onun anlamına metni kaydırarak ulaşabilirsiniz.. Her yorumun sizin için geçerli olmayabileceğini, cevabınızı kendi duygularınıza göre bulmanız gerektiğini unutmayın.\n', // Bold yapmak istediğiniz kısım
                                style: TextStyle(fontSize: 12, color: Colors.blueGrey), // Genel metin stili
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "\"Bu yöntem, yalnızca eğlenceli bir gelenek değil, aynı zamanda ruhsal bir rehberlik sunar. Hafız’ın derin mısralarında kendinizden bir parça bulabilir, içinizdeki huzuru keşfedebilirsiniz. Samimi bir niyetle kartınızı seçin ve Hafız’ın bilgeliğiyle yolunuzu aydınlatın!\"",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: Colors.black54,
                            height: 1.5,
                          ),
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

class BackWidget extends StatelessWidget {
  const BackWidget({super.key, required this.cardNumber});
  final int cardNumber;

  @override
  Widget build(BuildContext context) {
    int numberOfGazel = 100 + cardNumber;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$numberOfGazel. Gazel",
              textAlign: TextAlign.center,
              style: GoogleFonts.dancingScript(
                textStyle: const TextStyle(fontSize: 26, color: ColorStyles.appBackGroundColor),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              Poems.poemList[cardNumber],
              style: GoogleFonts.lora(
                textStyle: const TextStyle(fontSize: 13, color: ColorStyles.appBackGroundColor, height: 1.8),
              ),
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Divider(color: ColorStyles.appBackGroundColor, thickness: 2),
            const SizedBox(height: 20),
            Text(
              "Tevil",
              textAlign: TextAlign.center,
              style: GoogleFonts.dancingScript(
                textStyle: const TextStyle(fontSize: 26, color: ColorStyles.appBackGroundColor),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              Poems.tevilList[cardNumber],
              style: GoogleFonts.lora(
                textStyle: const TextStyle(fontSize: 14, color: ColorStyles.appBackGroundColor, height: 1.8),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

String baseUrl = "https://www.latamarte.com/media/d2/zgalleries/";
List<String> gaybinDiliImages = [
  '${baseUrl}7bc7116c86af029000ede4acebefd278/65341f0ba758d4afb9d80219_84-scent-of-the-beloved-prophet-jacob.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/653419bd3429ee2c4e12a9ad_116-the-prophet-abraham-1995-rev_sm.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6534140e766648c0b7cd645e_46-an.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6534137e1ca0dfa07c5cb04b_9-assembly-2000_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d309c7a3f2fe00712137_5-fire-reflourishing-prophet-abraham.png',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d2fb7ffbfe1c9ffa446e_2-graceful-1992jpg.jpeg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d2f0fcb104890be941c2_7-through-the-veil-2004_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d2e3de2f388da318df45_10-envy-1982_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d2d61bbe8548c2b67f5e_24-inner-turmoil-1977_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d29d6085624f4a549f95_26-natures-rythm-1996_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d2869f29cf647dfaf320_23-broken-sword-1985_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d205c7a3f21542710e5c_phoenix-song-1981.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d1f8de2f3807eb18c569_43-blissful-suffering_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d0d4ea7b3a6ed1f7cbb5_58-o-lord-2002_small-1.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d09ec7a3f23dd370ecae_73-blissful-connection-2009-rev_sma.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d090d2ca391ecef301c7_garden_of_eden-1990.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d0839f29cfd559fad6f8_80-contrast-in-creation-1976-rev_sm.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d077fcb10490b3e915c2_94-master-of-his-destiny-1987-rev_s.jpeg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d0677ffbfe3292fa1bce_nobility-unleashed-1986.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393d0598871b13a047011b5_fighting-the-devil-inside-1991_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393cfb81bbe852ea5b64baf_genesis-1973.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393cf4e8871b1ca206ffb8a_11-at-war-1988_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393cf35fcb10496eae9064d_30-song-of-harmony-2000_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393cf2ac3846fc7121f02cd_31-perfume-of-love-1999_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393cf1c9f29cf63d9fabc3c_41-to-bask-in-the-ray-of-love-1977.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393cf0d6201a3c7a788d380_dance_of_naure-1970-p-1080.png',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393cf00ea7b3a9ec0f7b0cb_jonah-1988-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393cef4e8ac2eaf23cea1c2_106-viciously-intertwined-1970-rev.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6393cebdc3846f50841f0131_divine-manefestation-ashura-1976-p.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/632ca001140ca657f82e3e07_beauty-unveiled-1981-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/632c9a00b9a9011e04865fa7_124-levitation-2013_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/632c9977f8eaf90340d1858f_115-night_s-engulfing-magic-1986_sm.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/632c9966af889e5bc6df6b75_114-crystal-ball-of-vision-1973-rev.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/632c99575ae0dbd738e29bc6_111-times-endless-grip-1991_small-p.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/632c99425651cff9dc84d898_110-bitter-grin-1989_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/632c99238c05be41fa8b915c_108-self-haven-2000_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/632c990ff5ea2e2c50bf7ea0_107-the-birds-and-the-fish-1985-re.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/632c98e13dc9540d721b4672_105-vengence-2006_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/632c984310f74a6f46c970ba_104-innocence-1986_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321efef09572c1e8c2fc5ac_103-what-price-freedom-1980_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321efc47ed7ee5fdd6c8afe_101-intercession-2007_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ef90e680278924420f4f_99-hardest-trial-prophet-abraham-and.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ef87d8c5b641f04b9593_97-hopeless-2004-rev_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ef7e0dfb7f60e6ac741d_96-ruined-village-2010_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ef74ec9f426d190b7c65_95-go-free-oh-bird-1989_small-p-10.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ef58f4a53e1a3c34d844_92-ravishing-fragrance-1985-rev_sma.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ef40cd25e07b10d163f8_90-scent-of-secrecy-1978_small-p-10.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ef1d6cc07c32c2fcba6e_87-scripture-2002-rev_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ef14474cd397f4d2be47_86-flight-in-revolution-1973-rev_sm.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ef0ffcf8153bf0824259_85-rainbow-1986-rev_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321eed0b9021a99f723378e_792-sketch-no-date_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321eeb3cabd983aaba5eda4_791-sketch-no-date-rev_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ee9e7ed7ee43e76c7e01_76-rapture-2005_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ee88a542e563863361d0_74-yet-she_s-all-smiles-2002-rev_sm.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ee74712c195eb2ffa15c_71-ambush-undated_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ee58aa8cdb265bd1e77b_68-a-fable-of-life-1988_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ee4fb70159c59218f2e2_67-doomed-to-destruction-1989_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ee3e02d7fb932646e1ca_66-self-liberation-2004_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ee34c5c1b16d94d52025_64-uncharted-road-1991_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321eddea4e900ca82104660_54-roots-mutable-1998_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ed556c587ba7a856a5bf_45-compassion-2001_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ed15ce5e2627267a87b7_40-whispering-the-secrets-1977_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ed0df4a53e36e434c442_39-tender-embrace-2000_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ecff0dfb7f5666ac51a2_37-implore-1983_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ecf0a542e54fc7335438_36-khayyam-1993_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ece3fcf8158e768238e9_35-seized-by-the-evil-inside-1993_s.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ecd5f51f523ef7ce4ffb_34-youth-remembered-1991_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ecc3e68027a81741e8cf_33-the-goddess-of-galaxies-1988_sma.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ecb63dd28af7192778ce_32-quo-vadis-1981_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ec8f1293be938c1c93f0_28-midnight-repose-1969_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ec872f25a79f1a2137d6_27-human-being-1992_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ec36e68027405c41e6bc_21-being-and-nothingness-intertwined.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ec25df642812949c2540_20-brutalized-by-power-1977_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ec16f774c0a0e62bbd45_19-living-thus-1975_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ec0887c8f4394c69e49e_18-craving-to-grow-1983_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ec00b28beb47d28a7142_17-plea-for-mercy-1998_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ebf3ade4b444100ba84c_16-inspired-by-the-muse-1977_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ebe63dd28a0ce72775ef_12-man_s-nature-2006_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321ebb8ade4b41ff00ba76e_8-holy-typhoon-2006_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321eb689faf8aa2ca4c79dc_3-joseph-1975_small.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/6321eb17d8c5b60a4c4b6bd1_1-four-elements-1983_small-p-1080.jpg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/62df7134938b2dcc6bf15abb_100-birth-of-hope-1990_small-p-1080.jpeg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/62de6710f5a6b679958db722_82-to-plead-for-the-sins-of-man-198.jpeg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/62ddd12163a8784eeea73a6c_91-the-lady-of-autumn-2002-rev_sm.jpeg',
  '${baseUrl}7bc7116c86af029000ede4acebefd278/62dabe943641f074c3f875b8_6-ethereal-love-1983_small.jpeg',
];
