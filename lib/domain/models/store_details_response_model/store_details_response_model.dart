class StoreDetailsResponseModel {
  final int status;
  final String message;
  final String image;
  final int id;
  final String title;
  final String details;
  final String services;
  final String about;

  StoreDetailsResponseModel({
    required this.status,
    required this.message,
    required this.image,
    required this.id,
    required this.title,
    required this.details,
    required this.services,
    required this.about,
  });
}