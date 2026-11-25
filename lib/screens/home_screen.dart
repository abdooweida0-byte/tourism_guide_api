import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../providers/attraction_provider.dart';
import '../../widgets/attraction_card.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AttractionProvider>().fetchAttractions();
    });
  }

  Future<void> refresh() async {
    await context.read<AttractionProvider>().fetchAttractions();
  }

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<AttractionProvider>();

    return Scaffold(

      backgroundColor: AppColors.background,

      appBar: AppBar(

        backgroundColor: AppColors.primary,

        elevation: 0,

        centerTitle: true,

        title: const Text(
          "Explore Egypt",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: currentIndex == 1
          ? const FavoritesScreen()
          : currentIndex == 2
              ? const Center(child: Text('Profile'))
              : RefreshIndicator(

        onRefresh: refresh,

        child: Column(

          children: [

            Container(

              padding: const EdgeInsets.all(15),

              color: AppColors.primary,

              child: TextField(

                decoration: InputDecoration(

                  hintText: "Search attractions",

                  prefixIcon: const Icon(Icons.search),

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(30),

                    borderSide: BorderSide.none,

                  ),
                ),
              ),
            ),

            Expanded(

              child: Builder(

                builder: (_) {

                  if (provider.isLoading) {

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (provider.error != null) {

                    return Center(

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [

                          const Icon(
                            Icons.error_outline,
                            size: 70,
                            color: Colors.red,
                          ),

                          const SizedBox(height: 15),

                          Text(
                            provider.error!,
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 20),

                          ElevatedButton(

                            onPressed: () {

                              provider.fetchAttractions();

                            },

                            child: const Text("Retry"),
                          )
                        ],
                      ),
                    );
                  }

                  if (provider.attractions.isEmpty) {

                    return const Center(

                      child: Text(
                        "No Attractions Found",
                      ),
                    );
                  }

                  return ListView.builder(

                    padding: const EdgeInsets.only(top: 10),

                    itemCount: provider.attractions.length,

                    itemBuilder: (context, index) {

                      return AttractionCard(

                        attraction:
                        provider.attractions[index],

                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (i) => setState(() => currentIndex = i),

        selectedItemColor: AppColors.primary,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore),
            label: "Explore",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: "Favorite",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}