import 'package:flutter/material.dart';

import '../constant/constants.dart';
import '../view/models/category_model.dart';
import 'cards/category_card.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultPadding),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 sütun
              crossAxisSpacing: 12, // Yatay boşluk
              mainAxisSpacing: 12, // Dikey boşluk
              childAspectRatio: 1 / 0.9, // 2 genişlik : 1 yükseklik
            ),
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return CategoryCard(
                image: categoryList[index].image,
                title: categoryList[index].title,
                press: () {
                  Navigator.pushNamed(context, categoryList[index].pageRoute);
                },
              );
            },
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
