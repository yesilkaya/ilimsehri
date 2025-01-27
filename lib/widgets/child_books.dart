import 'package:flutter/material.dart';

import '../constant/constants.dart';
import '../constant/route_constants.dart';
import '../view/models/book_model.dart';
import 'cards/child_book_card.dart';

class ChildBooks extends StatelessWidget {
  const ChildBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getBooksList(context, '14 Masum Serisi', masumlarBookList, bookDetailScreenRoute),
          _getBooksList(context, 'Peygamberler Serisi', peygamberlerBookList, bookDetailScreenRoute),
          _getBooksList(context, 'Diğerleri', otherBookList, bookDetailScreenRoute),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _getBooksList(BuildContext context, String title, List<BookModel> bookList, String pageRoute) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        SizedBox(
          height: 250,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.4,
              crossAxisCount: 1, // Her satırda 2 öğe olacak şekilde düzenleme
              crossAxisSpacing: 10.0, // Yatay boşluk
              mainAxisSpacing: 10.0, // Dikey boşluk
            ),
            scrollDirection: Axis.horizontal,
            itemCount: bookList.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: ChildBookCard(
                index: index,
                image: bookList[index].image,
                brandName: bookList[index].writer,
                title: bookList[index].name,
                price: bookList[index].price,
                priceAfetDiscount: bookList[index].priceAfetDiscount,
                dicountpercent: bookList[index].discountPerCent,
                press: () {
                  Navigator.pushNamed(
                    context,
                    bookDetailScreenRoute,
                    arguments: {'selectedBook': bookList[index]}, // Parametreyi burada geçiyoruz
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
