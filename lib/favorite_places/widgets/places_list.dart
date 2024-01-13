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
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: places.length,
      itemBuilder: (ctx, i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: places[i].image == null
              ? Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ),
                )
              : CircleAvatar(
                  radius: 26,
                  backgroundImage: FileImage(places[i].image!),
                ),
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
      ),
    ));
  }
}
