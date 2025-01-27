import 'package:flutter/material.dart';

import '../constant/constants.dart';
import '../constant/route_constants.dart';
import '../view/models/product_model.dart';
import 'cards/category_card.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> pageRoute = [
      kuranScreenRoute,
      sahifeiSeccadiyeScreenRoute,
      duaScreenRoute,
      munacatScreenRoute,
      zikirScreenRoute,
      cocukScreenRoute,
      gaybScreenRoute,
      eyyamullahScreenRoute,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: CategoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: AspectRatio(
                aspectRatio: 1 / 1.2, // Yüksekliği azaltmak için oranı değiştirebilirsiniz.
                child: CategoryCard(
                  image: CategoryList[index].image,
                  title: CategoryList[index].title,
                  press: () {
                    Navigator.pushNamed(context, pageRoute[index]);
                  },
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
