import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class PlaceItem {
  final String id;
  final String name;
  final File? image;
  final PlaceLocation? location;

  const PlaceItem({
    required this.id,
    required this.name,
    this.image,
    this.location,
  });
}
