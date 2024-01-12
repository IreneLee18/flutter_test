import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/favorite_places/models/place.dart';

class PlaceNotifier extends StateNotifier<List<PlaceItem>> {
  PlaceNotifier() : super(const []);

  void addPlace(PlaceItem place) {
    state = [place, ...state];
  }
}

final placeProvider = StateNotifierProvider<PlaceNotifier, List<PlaceItem>>(
  (ref) => PlaceNotifier(),
);
