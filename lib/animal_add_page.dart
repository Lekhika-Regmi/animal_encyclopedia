import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'animal_list_page.dart';
import 'controllers/animal_controller.dart';
import 'models/animal.dart';

class AnimalAddPage extends ConsumerStatefulWidget {
  const AnimalAddPage({super.key});

  @override
  ConsumerState<AnimalAddPage> createState() => _AnimalAddPageState();
}

class _AnimalAddPageState extends ConsumerState<AnimalAddPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String description = '';
  String group = '';
  String diet = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add new Animal")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // ✅ attach the key
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a name' : null,
                onChanged: (value) => name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Enter a description'
                    : null,
                onChanged: (value) => description = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Group'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a group' : null,
                onChanged: (value) => group = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Diet'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a diet' : null,
                onChanged: (value) => diet = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final controller = ref.read(animalControllerProvider);
                    final animal = Animal(
                      id: 0,
                      name: name,
                      description: description,
                      group: group,
                      diet: diet,
                    );
                    try {
                      await controller.addAnimal(animal);
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Animal added successfully!'),
                          ),
                        );
                        await Future.delayed(const Duration(milliseconds: 500));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AnimalListPage(),
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
