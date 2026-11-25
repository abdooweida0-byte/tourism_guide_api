import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/attraction_model.dart';
import '../providers/attraction_provider.dart';
import '../screens/details_screen.dart';

class AttractionCard extends StatelessWidget {

  final Attraction attraction;

  const AttractionCard({
    super.key,
    required this.attraction,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsScreen(
              attraction: attraction,
            ),
          ),
        );
      },

      child: Card(
        margin:
        const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),

        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(18),
        ),

        child: Row(
          children: [

            ClipRRect(
              borderRadius:
              BorderRadius.circular(18),

              child: CachedNetworkImage(
                imageUrl: attraction.image,
                width: 120,
                height: 100,
                fit: BoxFit.cover,

                placeholder: (context, url) =>
                const Center(
                  child: CircularProgressIndicator(),
                ),

                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              )
            ),

            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.all(10),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      attraction.title,
                      style:
                      const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      attraction.description,
                      maxLines: 2,
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [

                        const Icon(
                          Icons.location_on,
                          size: 18,
                        ),

                        Text(
                          attraction.location,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Consumer<AttractionProvider>(
              builder: (context, provider, child) {
                final fav = provider.isFavorite(attraction);
                return IconButton(
                  onPressed: () => provider.toggleFavorite(attraction),
                  icon: Icon(
                    fav ? Icons.favorite : Icons.favorite_border,
                    color: fav ? Colors.red : Colors.grey,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}