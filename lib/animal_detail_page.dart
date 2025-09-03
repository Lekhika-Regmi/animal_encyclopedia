import 'package:animal_encyclopedia/providers/animal_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimalDetailPage extends ConsumerWidget {
  final int animalId;

  const AnimalDetailPage({super.key, required this.animalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animalAsync = ref.watch(animalDetailProvider(animalId));

    return Stack(
      children: [
        // Background image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/animalDe.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Foreground content
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Animal Detail'),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: animalAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('Error: $err')),
            data: (animal) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${animal.name}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.teal[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '  Group: ${animal.group}',
                    style: TextStyle(color: Colors.teal[900], fontSize: 20),
                  ),
                  Text(
                    '  Diet: ${animal.diet}',
                    style: TextStyle(color: Colors.teal[900], fontSize: 20),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '  ${animal.description}',
                    style: TextStyle(color: Colors.teal[900], fontSize: 18),
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
