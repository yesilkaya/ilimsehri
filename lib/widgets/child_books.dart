import 'package:flutter/material.dart';

import '../constant/constants.dart';
import '../constant/route_constants.dart';
import '../view/models/book_model.dart';
import 'cards/child_book_card.dart';

class ChildBooks extends StatelessWidget {
  const ChildBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 60),
      children: [
        _getBooksList(context, '14 Masum Serisi', masumlarBookList, bookDetailScreenRoute),
        _getBooksList(context, 'Peygamberler Serisi', peygamberlerBookList, bookDetailScreenRoute),
        _getBooksList(context, 'Diğerleri', otherBookList, bookDetailScreenRoute),
      ],
    );
  }

  Widget _getBooksList(BuildContext context, String title, List<BookModel> bookList, String pageRoute) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18)),
        ),
        bookList.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Text(
                    'Kitap bulunamadı.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Her satırda 2 kitap olacak
                  childAspectRatio: 0.7, // Yükseklik-genişlik oranı
                  crossAxisSpacing: 10.0, // Yatay boşluk
                  mainAxisSpacing: 10.0, // Dikey boşluk
                ),
                itemCount: bookList.length,
                itemBuilder: (context, index) => ChildBookCard(
                  index: index,
                  image: bookList[index].image,
                  brandName: bookList[index].writer,
                  title: bookList[index].name,
                  price: bookList[index].price,
                  priceAfetDiscount: bookList[index].priceAfetDiscount,
                  dicountpercent: bookList[index].discountPerCent,
                  press: () => _navigateToDetail(context, pageRoute, bookList[index]),
                ),
              ),
      ],
    );
  }

  void _navigateToDetail(BuildContext context, String pageRoute, BookModel book) {
    Navigator.pushNamed(
      context,
      pageRoute,
      arguments: {'selectedBook': book},
    );
  }
}
