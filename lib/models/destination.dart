/// Model de date pentru o destinație de călătorie
class Destination {
  final String id;
  final String name;
  final String country;
  final String imageUrl;
  final String description;
  final List<String> attractions;
  final List<String> seasons; // Sezoanele recomandate (Primăvară, Vară, Toamnă, Iarnă)
  final double budget; // Bugetul estimat în EUR
  bool visited;

  Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.imageUrl,
    required this.description,
    required this.attractions,
    required this.seasons,
    required this.budget,
    this.visited = false,
  });

  /// Returnează sezoanele ca string pentru afișare
  String get seasonsDisplay => seasons.join(', ');

  /// Returnează bugetul formatat
  String get budgetDisplay => '€${budget.toStringAsFixed(0)}';
}