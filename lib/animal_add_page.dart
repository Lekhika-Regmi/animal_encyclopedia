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
    return Stack(
      children: [
        // Background image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/animalAd.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Foreground content
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              "Add new Animal",
              style: TextStyle(color: Colors.blueGrey),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.teal[900]),
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.teal),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Enter a name' : null,
                    onChanged: (value) => name = value,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.teal[900]),
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.teal),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter a description'
                        : null,
                    onChanged: (value) => description = value,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.teal[900]),
                    decoration: const InputDecoration(
                      labelText: 'Group',
                      labelStyle: TextStyle(color: Colors.teal),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Enter a group' : null,
                    onChanged: (value) => group = value,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.teal[900]),
                    decoration: const InputDecoration(
                      labelText: 'Diet',
                      labelStyle: TextStyle(color: Colors.teal),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
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
                            await Future.delayed(
                              const Duration(milliseconds: 500),
                            );
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
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.green[300],
                      ),
                    ),
                    child: const Text('Add', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
