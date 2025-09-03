import 'package:animal_encyclopedia/providers/animal_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'animal_detail_page.dart';

class AnimalListPage extends ConsumerWidget {
  const AnimalListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animalAsync = ref.watch(animalListProvider);

    return Stack(
      children: [
        // Background image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/animalLi.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Foreground content
        Scaffold(
          backgroundColor: Colors.transparent, // Makes Scaffold see-through
          appBar: AppBar(
            title: const Text("Animals"),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: animalAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text("Error: $err")),
            data: (animals) {
              final filtered = animals; // no filtering applied
              return ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final animal = filtered[index];
                  final isFav = ref
                      .watch(favoritesProvider)
                      .contains(animal.id);

                  return ListTile(
                    title: Text(
                      animal.name,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ), // visible on background
                    ),
                    subtitle: Text(
                      '${animal.group} - ${animal.diet}',
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite),
                      color: isFav ? Colors.red : Colors.grey,
                      onPressed: () {
                        ref.read(favoritesProvider.notifier).toggle(animal.id);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AnimalDetailPage(animalId: animal.id),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
