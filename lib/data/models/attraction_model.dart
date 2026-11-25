class Attraction {
  final String title;
  final String description;
  final String image;
  final String location;

  Attraction({
    required this.title,
    required this.description,
    required this.image,
    required this.location,
  });

  factory Attraction.fromJson(
      Map<String, dynamic> json,
      String location,
      ) {
    return Attraction(
      title: json["title"] ?? "",
      description: json["extract"] ?? "",
      image: json["thumbnail"]?["source"] ?? "",
      location: location,
    );
  }
}