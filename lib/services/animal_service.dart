import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../models/animal.dart';

class AnimalService {
  final Dio _dio = Dio();
  //final String baseUrl = 'http://localhost:3001';
  final String baseUrl = 'http://10.0.2.2:3001';

  Future<List<Animal>> fetchAnimalsService() async {
    try {
      final response = await _dio.get('$baseUrl/animals');

      // Ensure it's a list of maps
      final List<dynamic> data = response.data;
      final List<Animal> animals = data.map((item) {
        return Animal.fromJson(item as Map<String, dynamic>);
      }).toList();

      return animals;
    } catch (e) {
      throw Exception('Error fetching animals: $e');
    }
  }

  Future<Animal> fetchAnimalDetail(int id) async {
    _dio.interceptors.add(PrettyDioLogger());
    final response = await _dio.get('$baseUrl/animals/$id');
    return Animal.fromJson(response.data);
  }

  Future<void> addAnimal(Animal animal) async {
    try {
      await _dio.post(
        '$baseUrl/animals',
        data: {
          'name': animal.name,
          'description': animal.description,
          'group': animal.group,
          'diet': animal.diet,
        },
      );
    } catch (e) {
      throw Exception('Failed to add animal: $e');
    }
  }
}
