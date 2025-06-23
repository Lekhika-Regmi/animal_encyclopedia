import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'animal_list_page.dart'; // <- Make sure this import is correct

final appTitleProvider = Provider<String>((ref) {
  return 'Animal Encyclopedia';
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(appTitleProvider);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to $title'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to AnimalListPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AnimalListPage()),
                );
              },
              child: const Text('Browse Animals'),
            ),
          ],
        ),
      ),
    );
  }
}
