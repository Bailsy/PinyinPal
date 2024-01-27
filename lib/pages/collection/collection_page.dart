// collection_page.dart
import 'package:flutter/material.dart';
import 'package:pinyinpal/models/collection_model.dart';
import 'package:pinyinpal/models/hsk_entry.dart';
import 'package:pinyinpal/pages/character_profile/character_profile.dart';
import 'package:provider/provider.dart';

class CollectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CollectionModel(),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<CollectionModel>(
      builder: (context, collectionModel, child) {
        if (collectionModel.hskEntries.isEmpty) {
          // If characters are not loaded, trigger loading
          collectionModel.loadData();
          return Center(child: CircularProgressIndicator());
        } else {
          // Build the grid with loaded characters
          return Container(
            margin: EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
              itemCount: collectionModel.hskEntries.length,
              itemBuilder: (context, index) {
                return _buildCharacterItem(
                  context,
                  collectionModel,
                  collectionModel.hskEntries[index],
                );
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildCharacterItem(BuildContext context,
      CollectionModel collectionModel, HskEntry character) {
    return GestureDetector(
      onTap: () async {
        // Navigate to CharacterProfilePage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CharacterProfileBody(selectedCharacter: character),
          ),
        );
        print(character.simplified);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff303238),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            character.simplified,
            style: TextStyle(color: Colors.grey, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
