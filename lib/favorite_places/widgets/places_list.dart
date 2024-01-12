import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/favorite_places/providers/place.dart';
import 'package:test/favorite_places/screens/place_detail.dart';

class PlacesList extends ConsumerWidget {
  const PlacesList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(placeProvider);
    print(places);

    if (places.isEmpty) {
      return Center(
        child: Text(
          'Please add some place.',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      );
    }

    return (ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, i) => ListTile(
        title: Text(
          places[i].name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => PlaceDetailScreen(place: places[i]),
              ));
        },
      ),
    ));
  }
}
