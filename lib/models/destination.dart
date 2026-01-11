class Destination {
  final String id;
  final String name;
  final String country;
  final String imageUrl;
  final String description;
  final List<String> attractions;
  final String bestPeriod;
  bool visited;

  Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.imageUrl,
    required this.description,
    required this.attractions,
    required this.bestPeriod,
    this.visited = false,
  });
}