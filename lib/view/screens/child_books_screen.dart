import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/child_books.dart';

class ChildBooksScreen extends ConsumerStatefulWidget {
  const ChildBooksScreen({super.key});

  @override
  ChildBooksState createState() => ChildBooksState();
}

class ChildBooksState extends ConsumerState<ChildBooksScreen> {
  @override
  void initState() {
    super.initState();
    //final notifier = ref.read(cityProvider.notifier);
    //notifier.init(ref);
  }

  @override
  Widget build(BuildContext context) {
    //final state = ref.watch(cityProvider);

    return Scaffold(
      appBar: DefaultAppBar.buildAppBar(context, 'Kitaplar'),
      body: const ChildBooks(),
    );
  }
}
