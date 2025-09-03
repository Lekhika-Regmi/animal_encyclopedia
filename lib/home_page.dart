import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'animal_add_page.dart';
import 'animal_list_page.dart';

final appTitleProvider = Provider<String>((ref) {
  return 'Animal Encyclopedia';
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(appTitleProvider);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     title,
      //     style: TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 20,
      //       color: Colors.blueGrey,
      //     ),
      //   ),
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/animalEn.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to $title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to AnimalListPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AnimalListPage()),
                  );
                },
                child: const Text(
                  'Browse Animals',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to AnimalListPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AnimalAddPage()),
                  );
                },
                child: const Text(
                  'Add Animals',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
