import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/animal.dart';
import '../services/animal_service.dart';

final animalControllerProvider = Provider<AnimalController>((ref) {
  return AnimalController(AnimalService());
});

class AnimalController {
  final AnimalService _service;

  AnimalController(this._service);

  Future<List<Animal>> fetchAnimals() {
    return _service.fetchAnimalsService();
  }

  Future<void> addAnimal(Animal animal) {
    return _service.addAnimal(animal);
  }

  List<Animal> filterByGroup(List<Animal> animals, String group) {
    return animals
        .where((a) => a.group.toLowerCase() == group.toLowerCase())
        .toList();
  }

  List<Animal> filterByDiet(List<Animal> animals, String diet) {
    return animals
        .where((a) => a.diet.toLowerCase() == diet.toLowerCase())
        .toList();
  }

  List<Animal> filterByGroupAndDiet(
    List<Animal> animals,
    String group,
    String diet,
  ) {
    return animals
        .where(
          (a) =>
              a.group.toLowerCase() == group.toLowerCase() &&
              a.diet.toLowerCase() == diet.toLowerCase(),
        )
        .toList();
  }

  Future<Animal> fetchAnimalDetail(int id) {
    return _service.fetchAnimalDetail(id);
  }
}
