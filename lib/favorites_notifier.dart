import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesNotifier extends StateNotifier<Set<int>> {
  //starting with empty favorites
  FavoritesNotifier() : super({});
  void toggle(int animalId) {
    if (state.contains(animalId)) {
      //removing if already fav
      state = {...state}..remove(animalId);
    } else {
      //adding if not fav
      state = {...state}..add(animalId);
    }
  }
}
