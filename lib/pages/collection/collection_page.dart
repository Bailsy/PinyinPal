import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinyinpal/models/collection_model.dart';
import 'package:pinyinpal/models/hsk_entry.dart';
import 'package:pinyinpal/providers/character_profile_provider.dart';
import 'package:provider/provider.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late List<Map<String, dynamic>> data;

  @override
  void initState() {
    super.initState();
    getConfidence();
  }

  Future<void> getConfidence() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String filePath = '${documentsDirectory.path}/hsk2.json';

    File file = File(filePath);
    String jsonString = await file.readAsString();

    // Parse JSON content into a Dart list of maps
    List<dynamic> jsonList = jsonDecode(jsonString);
    setState(() {
      data = List<Map<String, dynamic>>.from(jsonList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final collectionModel = Provider.of<CollectionModel>(context);

    return _buildBody(collectionModel);
  }

  Widget _buildBody(CollectionModel collectionModel) {
    if (collectionModel.hskEntries.isEmpty) {
      // If characters are not loaded, trigger loading
      collectionModel.loadCollectionData();
      return const Center(child: CircularProgressIndicator());
    } else {
      // Build the grid with loaded characters
      return Container(
        margin: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1.0,
          ),
          itemCount: collectionModel.hskEntries.length,
          itemBuilder: (context, index) {
            //if collectionmodel is initialist, otherwise return loading icon

            if (data.isEmpty) {
              return const CircularProgressIndicator();
            } else {
              return _buildCharacterItem(
                  context,
                  collectionModel.hskEntries[index],
                  collectionModel.getColor(data[index]["score"]));
            }
          },
        ),
      );
    }
  }

  Widget _buildCharacterItem(
      BuildContext context, HskEntry character, Color confidenceColor) {
    return GestureDetector(
      onTap: () async {
        // Navigate to CharacterProfilePage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterProfileProvider(
              hskCharacter: character,
              confidence: confidenceColor,
            ),
          ),
        );
        print(character.simplified);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff303238),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            character.simplified,
            style: TextStyle(color: confidenceColor, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
