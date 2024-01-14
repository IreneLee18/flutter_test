import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/favorite_places/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool isSelected;
  const MapScreen({
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
    this.isSelected = true,
    super.key,
  });

  @override
  State<MapScreen> createState() {
    return _MapState();
  }
}

class _MapState extends State<MapScreen> {
  LatLng? _pickPosition;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelected ? 'Pick your Location' : 'Your Location'),
        actions: [
          if (widget.isSelected)
            IconButton(
              onPressed: () {
                Navigator.pop(context, _pickPosition);
              },
              icon: const Icon(Icons.save),
            )
        ],
      ),
      body: GoogleMap(
        onTap: (position) {
          setState(() {
            _pickPosition = position;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 16,
        ),
        markers: (_pickPosition == null && widget.isSelected)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickPosition ??
                      LatLng(
                        widget.location.latitude,
                        widget.location.longitude,
                      ),
                )
              },
      ),
    );
  }
}
