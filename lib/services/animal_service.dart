import 'package:dio/dio.dart';

import '../models/animal.dart';

class AnimalService {
  final Dio _dio = Dio();
  // final String baseUrl = 'http://localhost:3000'; // Update port if needed
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<List<Animal>> fetchAnimals() async {
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
    final response = await _dio.get('$baseUrl/animals/$id');
    return Animal.fromJson(response.data);
  }
}
