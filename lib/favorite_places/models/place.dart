import 'dart:io';

class PlaceItem {
  final String id;
  final String name;
  final File? image;
  final String? location;

  const PlaceItem({
    required this.id,
    required this.name,
    this.image,
    this.location
  });
}
