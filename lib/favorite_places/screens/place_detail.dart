import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test/favorite_places/models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  final PlaceItem place;
  const PlaceDetailScreen({
    required this.place,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Stack(
        children: [
          if (place.image != null) Image.file(place.image!),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                if (place.location?.locationImage != null)
                  CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        NetworkImage(place.location?.locationImage ?? ''),
                  ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.transparent,
                      Colors.black54,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                  child: Text(
                    place.location?.address ?? 'No Address',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
