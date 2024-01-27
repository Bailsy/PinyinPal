// providers.dart
import 'package:flutter/material.dart';
import 'package:pinyinpal/models/collection_model.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  AppProviders({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CollectionModel()),

        // Add other providers as needed
      ],
      child: child,
    );
  }
}
