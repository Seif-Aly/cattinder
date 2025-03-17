class Cat {
  final String id;
  final String imageUrl;
  final String breedName;
  final String? description;
  final String? temperament;
  final String? origin;

  Cat({
    required this.id,
    required this.imageUrl,
    required this.breedName,
    this.description,
    this.temperament,
    this.origin,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    final breedList = json['breeds'] as List? ?? [];
    final breedJson = breedList.isNotEmpty ? breedList[0] : null;

    return Cat(
      id: json['id'] ?? '',
      imageUrl: json['url'] ?? '',
      breedName:
          breedJson != null
              ? (breedJson['name'] ?? 'Unknown Breed')
              : 'Unknown Breed',
      description: breedJson?['description'],
      temperament: breedJson?['temperament'],
      origin: breedJson?['origin'],
    );
  }
}
