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
      body: Image.file(place.image!),
    );
  }
}
