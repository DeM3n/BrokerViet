// lib/models/service_model.dart

class ServiceModel {
  final String id;
  final String title;
  final String subtitle;
  final String providerName;
  final String price;
  final double rating;
  final List<String> tags;

  const ServiceModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.providerName,
    required this.price,
    required this.rating,
    required this.tags,
  });
}