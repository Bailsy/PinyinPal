import 'package:flutter/material.dart';
import 'package:pinyinpal/models/collection_model.dart';

class CollectionProvider extends ChangeNotifier {
  late CollectionModel _collectionModel;

  CollectionProvider() {
    _collectionModel = CollectionModel();
  }

  CollectionModel get collectionModel => _collectionModel;
}
