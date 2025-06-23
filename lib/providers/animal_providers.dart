import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/animal_controller.dart';
import '../favorites_notifier.dart';
import '../models/animal.dart';

final animalListProvider = FutureProvider<List<Animal>>((ref) async {
  final controller = ref.read(animalControllerProvider);
  return controller.fetchAnimals();
});

final filteredByGroupProvider = Provider.family<List<Animal>, String>((
  ref,
  group,
) {
  final List<Animal> animals = ref
      .watch(animalListProvider)
      .maybeWhen(data: (data) => data, orElse: () => <Animal>[]);

  final controller = ref.read(animalControllerProvider);
  return controller.filterByGroup(animals, group);
});

final filteredByDietProvider = Provider.family<List<Animal>, String>((
  ref,
  diet,
) {
  final List<Animal> animals = ref
      .watch(animalListProvider)
      .maybeWhen(data: (data) => data, orElse: () => <Animal>[]);

  final controller = ref.read(animalControllerProvider);
  return controller.filterByDiet(animals, diet);
});

final filteredByGroupAndDietProvider =
    Provider.family<List<Animal>, Map<String, String>>((ref, params) {
      final group = params['group'] ?? '';
      final diet = params['diet'] ?? '';
      final List<Animal> animals = ref
          .watch(animalListProvider)
          .maybeWhen(data: (data) => data, orElse: () => <Animal>[]);

      final controller = ref.read(animalControllerProvider);
      return controller.filterByGroupAndDiet(animals, group, diet);
    });

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<int>>((
  ref,
) {
  return FavoritesNotifier();
});

final animalDetailProvider = FutureProvider.family<Animal, int>((
  ref,
  id,
) async {
  final controller = ref.read(animalControllerProvider);
  return controller.fetchAnimalDetail(id);
});
