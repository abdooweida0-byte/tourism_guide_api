import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/attraction_provider.dart';
import '../widgets/attraction_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<AttractionProvider>().favorites;

    if (favorites.isEmpty) {
      return const Center(child: Text('No favorites yet'));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return AttractionCard(attraction: favorites[index]);
      },
    );
  }
}
