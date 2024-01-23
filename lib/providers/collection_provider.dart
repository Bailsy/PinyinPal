import 'package:flutter/material.dart';
import 'package:pinyinpal/models/collection_model.dart';
import 'package:pinyinpal/pages/collection/collection_page.dart';
import 'package:provider/provider.dart';

// Import other necessary packages and files

class CollectionProvider extends StatelessWidget {
  const CollectionProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Provider to provide the CollectionModel to the widget tree
    return ChangeNotifierProvider(
      create: (_) => CollectionModel(),
      child: CollectionPage(),
    );
  }
}
