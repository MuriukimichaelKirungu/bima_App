class InsurancePlan {
  final String id;
  final String name;
  final String description;
  final double price;
  final String type; // e.g. Health, Auto, Life
  final String imageUrl;

  InsurancePlan({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.type,
    required this.imageUrl,
  });
}
