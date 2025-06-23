class Animal {
  final int id;
  final String name;
  final String description;
  final String group; // e.g., Mammals, Birds, Amphibians
  final String diet; // e.g., Herbivorous, Carnivorous, Omnivorous

  Animal({
    required this.id,
    required this.name,
    required this.description,
    required this.group,
    required this.diet,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      group: json['group'],
      diet: json['diet'],
    );
  }
}
