import '../models/attraction_model.dart';

import '../services/api_service.dart';

class AttractionRepository{

  final ApiService apiService = ApiService();

  Future<List<Attraction>> fetchAttractions() async{

    final places = [
      {
        "api": "Great_Pyramid_of_Giza",
        "location": "Giza",
      },
      {
        "api": "Luxor_Temple",
        "location": "Luxor",
      },
      {
        "api": "Abu_Simbel",
        "location": "Aswan",
      },
      {
        "api": "Cairo_Tower",
        "location": "Cairo",
      },
      {
        "api": "Bibliotheca_Alexandrina",
        "location": "Alexandria",
      },
      {
        "api": "Dendera_Temple ",
        "location": "Dandra",
      },
    ];

    List<Attraction> attractions = [];

    for (final place in places) {
      final json = await apiService.getPlace(place["api"]!);

      attractions.add(
        Attraction.fromJson(
          json,
          place["location"]!,
        ),
      );
    }

    return attractions;

  }

}