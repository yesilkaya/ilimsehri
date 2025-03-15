// For demo only

import '../../constant/constants.dart';

class ProductModel {
  final String image;
  final String title;

  ProductModel({
    required this.image,
    required this.title,
  });
}

List<ProductModel> categoryList = [
  ProductModel(image: kuranSvgPath, title: "Kur'an-ı Kerim"),
  ProductModel(image: sahifeiSeccadiyeImgPath, title: "Sahife-i Seccadiye"),
  ProductModel(image: dualarImgPath, title: "Dualar"),
  ProductModel(image: munacatlarImgPath, title: "Münacatlar"),
  ProductModel(image: zikirImgPath, title: "Zikir"),
  ProductModel(image: cocukImgPath, title: "Kitaplar"),
  ProductModel(image: eyyamullahImgPath, title: "Dini Günler"),
  ProductModel(image: gaybImgPath, title: "Gayb'ın Dili"),
  ProductModel(image: ramazanImagePath, title: "Ramazan Ayı"),
  ProductModel(image: ehlibeytImagePath, title: "Ehlibeyt'in Hayatı"),
];
