import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/favorite_places/models/place.dart';
import 'package:test/favorite_places/providers/place.dart';
import 'package:test/favorite_places/screens/new_place.dart';
import 'package:test/favorite_places/widgets/places_list.dart';

class PlaceScreen extends ConsumerStatefulWidget {
  const PlaceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PlaceState();
  }
}

class _PlaceState extends ConsumerState<PlaceScreen> {
  late Future<void> _placeFuture;

  void _onAddNewPlace(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => const NewPlaceScreen(),
        ));
  }

  @override
  void initState() {
    super.initState();
    _placeFuture = ref.read(placeProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placeProvider);
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
      body: FutureBuilder(
        future: _placeFuture,
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : PlacesList(places: places),
      ),
    );
  }
}
