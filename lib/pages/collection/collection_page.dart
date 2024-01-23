import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pinyinpal/models/collection_model.dart';
import 'package:pinyinpal/providers/collection_provider.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionModel collectionModel = Provider.of<CollectionModel>(context);

    return ChangeNotifierProvider(
      create: (_) =>
          CollectionModel(), // You need to create your CollectionModel
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    // Your CollectionPage content goes here
    return Center(
      child: Text('<-- Coming soon -->'),
    );
  }
}
