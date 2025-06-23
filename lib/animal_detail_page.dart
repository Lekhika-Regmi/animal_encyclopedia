import 'package:animal_encyclopedia/providers/animal_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimalDetailPage extends ConsumerWidget {
  final int animalId;

  const AnimalDetailPage({super.key, required this.animalId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animalAsync = ref.watch(animalDetailProvider(animalId));

    return Scaffold(
      appBar: AppBar(title: Text('Animal Detail')),
      body: animalAsync.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (animal) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(animal.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text('Group: ${animal.group}'),
              Text('Diet: ${animal.diet}'),
              const SizedBox(height: 12),
              Text(animal.description),
            ],
          ),
        ),
      ),
    );
  }
}
