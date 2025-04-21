import '../../constant/constants.dart';
import '../../constant/route_constants.dart';

class CategoryModel {
  final String image;
  final String title;
  final String pageRoute;

  CategoryModel({
    required this.image,
    required this.title,
    required this.pageRoute,
  });
}

List<CategoryModel> categoryList = [
  CategoryModel(image: kuranSvgPath, title: "Kur'an-ı Kerim", pageRoute: kuranScreenRoute),
  CategoryModel(image: fikihImagePath, title: "Fıkıh", pageRoute: fikihScreenRoute),
  CategoryModel(image: munacatlarImgPath, title: "Dua ve Münacat", pageRoute: duaMunaacatScreenRoute),
  // CategoryModel(image: munacatlarImgPath, title: "Münacatlar", pageRoute: munacatScreenRoute),
  CategoryModel(image: aylarinAmelleriImagePath, title: "Ayların Amelleri", pageRoute: aylarinAmelleriScreenRoute),
  CategoryModel(image: tefsirImagePath, title: "El-Mizan Tefsiri", pageRoute: tefsirScreenRoute),
  CategoryModel(image: cocukImgPath, title: "Kitaplar", pageRoute: cocukScreenRoute),
  CategoryModel(image: ehlibeytImagePath, title: "Ehlibeyt'in Hayatı", pageRoute: ehlibeytScreenRoute),
  CategoryModel(image: ramazanImagePath, title: "Ramazan Ayı", pageRoute: ramazanScreenRoute),
  CategoryModel(image: gaybImgPath, title: "Gayb'ın Dili", pageRoute: gaybScreenRoute),
  CategoryModel(image: eyyamullahImgPath, title: "Dini Günler", pageRoute: eyyamullahScreenRoute),
  CategoryModel(image: zikirImgPath, title: "Zikir", pageRoute: zikirScreenRoute),
  CategoryModel(image: fatimaAlidirImagePath, title: "Fatıma Ali'dir", pageRoute: fatimaAlidirScreenRoute),
];
