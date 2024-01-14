import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/favorite_places/models/place.dart';
import 'package:test/favorite_places/providers/place.dart';
import 'package:test/favorite_places/widgets/image_input.dart';
import 'package:test/favorite_places/widgets/location_input.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() {
    return _NewPlaceState();
  }
}

class _NewPlaceState extends ConsumerState<NewPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  File? _image;
  PlaceLocation? _location;

  void onPickImage(File image) {
    _image = image;
  }

  void onPickLocation(PlaceLocation location) {
    _location = location;
  }

  void _onSave(WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context);
      ref.read(placeProvider.notifier).addPlace(
            PlaceItem(
              id: DateTime.now().toString(),
              name: _title,
              image: _image,
              location: _location,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('title'),
                ),
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      value.isEmpty ||
                      value.length > 50) {
                    return 'InValid title.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              const SizedBox(height: 16),
              ImageInput(onPickImage: onPickImage),
              const SizedBox(height: 16),
              LocationInput(onPickLocation: onPickLocation),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('New Place'),
                    onPressed: () {
                      _onSave(ref);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
