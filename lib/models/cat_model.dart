class Cat {
  final String imageUrl;
  final String breedName;
  final String? temperament;
  final String? origin;
  final String? description;
  final String? lifeSpan;

  Cat({
    required this.imageUrl,
    required this.breedName,
    this.temperament,
    this.origin,
    this.description,
    this.lifeSpan,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    final breed = json['breeds'][0];
    return Cat(
      imageUrl: json['url'],
      breedName: breed['name'],
      temperament: breed['temperament'],
      origin: breed['origin'],
      description: breed['description'],
      lifeSpan: breed['life_span'],
    );
  }
}
