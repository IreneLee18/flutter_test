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

  String get locationImage {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=14&size=600x300&maptype=roadmap&markers=size:mid%7Ccolor:red%7C$latitude,$longitude&key=AIzaSyBxyWtTB_khGyOYBRb4-Z7-mWU5tNNktVA';
  }
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
