// For demo only

import '../../constant/constants.dart';

class ProductModel {
  final String image;
  final String title;
  final String? brandName;
  final double? price;
  final double? priceAfetDiscount;
  final int? dicountpercent;

  ProductModel({
    required this.image,
    required this.title,
    this.brandName,
    this.price,
    this.priceAfetDiscount,
    this.dicountpercent,
  });
}

List<ProductModel> CategoryList = [
  ProductModel(image: kuranSvgPath, title: "Kur'an-ı Kerim"),
  ProductModel(image: sahifeiSeccadiyeImgPath, title: "Sahife-i Seccadiye"),
  ProductModel(image: dualarImgPath, title: "Dualar"),
  ProductModel(image: munacatlarImgPath, title: "Münacatlar"),
  ProductModel(image: zikirImgPath, title: "Zikir"),
  ProductModel(image: cocukImgPath, title: "Kitaplar"),
  ProductModel(image: eyyamullahImgPath, title: "Dini Günler"),
  ProductModel(image: gaybImgPath, title: "Gayb'ın Dili"),
  ProductModel(image: ramazanImagePath, title: "Ramazan"),
];
