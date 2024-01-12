import 'package:flutter/material.dart';
import 'package:test/favorite_places/screens/new_place.dart';
import 'package:test/favorite_places/widgets/places_list.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({super.key});

  void _onAddNewPlace(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => const NewPlaceScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              _onAddNewPlace(context);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: const PlacesList(),
    );
  }
}
