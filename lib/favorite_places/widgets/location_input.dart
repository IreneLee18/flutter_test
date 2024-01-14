import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:test/favorite_places/models/place.dart';
import 'package:test/favorite_places/screens/map.dart';

const key = 'AIzaSyBxyWtTB_khGyOYBRb4-Z7-mWU5tNNktVA';

class LocationInput extends StatefulWidget {
  const LocationInput({
    required this.onPickLocation,
    super.key,
  });

  final void Function(PlaceLocation location) onPickLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  bool _isGettingLocation = false;
  PlaceLocation? _pickLocation;

  void _savePlace(double lat, double lng) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lat},${lng}&key=$key');

    final res = await http.get(url);
    final data = json.decode(res.body);
    final address = data['results'][0]['formatted_address'];

    final placeLocation =
        PlaceLocation(latitude: lat, longitude: lng, address: address);
    widget.onPickLocation(placeLocation);
    setState(() {
      _isGettingLocation = false;
      _pickLocation = placeLocation;
    });
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingLocation = true;
    });
    locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) return;
    _savePlace(lat, lng);
  }

  void _selectLocation() async {
    final pickLocation = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(),
      ),
    );
    if (pickLocation == null) return;
    _savePlace(pickLocation.latitude, pickLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
          ),
          child: _isGettingLocation
              ? const CircularProgressIndicator()
              : _pickLocation != null
                  ? Image.network(
                      _pickLocation!.locationImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : Text(
                      'No location chosen',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current Location'),
            ),
            TextButton.icon(
              onPressed: _selectLocation,
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
            ),
          ],
        )
      ],
    );
  }
}
