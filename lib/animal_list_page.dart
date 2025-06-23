import 'package:animal_encyclopedia/providers/animal_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'animal_detail_page.dart';

class AnimalListPage extends ConsumerWidget {
  const AnimalListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animalAsync = ref.watch(animalListProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Animals")),
      body: animalAsync.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
        data: (animals) {
          // Example: Filtered by mammals
          // final filtered = ref.watch(filteredByGroupProvider('Mammals'));
          final filtered = animals; // no filtering applied
          print('Filtered animal IDs: ${filtered.map((a) => a.id).toList()}');

          return ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final animal = filtered[index];
              final isFav = ref.watch(favoritesProvider).contains(animal.id);
              return ListTile(
                title: Text(animal.name),
                trailing: IconButton(
                  color: isFav ? Colors.red : Colors.grey,
                  onPressed: () {
                    ref.read(favoritesProvider.notifier).toggle(animal.id);
                  },
                  icon: Icon(Icons.favorite),
                ),
                onTap: () {
                  //navigate to detail screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AnimalDetailPage(animalId: animal.id),
                    ),
                  );
                },
                subtitle: Text('${animal.group} - ${animal.diet}'),
              );
            },
          );
        },
      ),
    );
  }
}
