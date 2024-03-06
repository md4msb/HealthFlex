import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthflex_giphy/controller/home_cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeCubit homeCubit;

  @override
  void initState() {
    homeCubit = BlocProvider.of<HomeCubit>(context);
    homeCubit.getTrendingGifs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Trending Gifs"),
        centerTitle: true,
      ),
      body: _buildBodyCanvas(
        screenSize: screenSize,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _searchBar(context),
            const SizedBox(height: 10),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is LoadingState && homeCubit.trendingGifs.isEmpty) {
                  return const CircularProgressIndicator();
                }
                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // number of items in each row
                      mainAxisSpacing: 8.0, // spacing between rows
                      crossAxisSpacing: 8.0, // spacing between columns
                    ),
                    itemCount: homeCubit.trendingGifs.length,
                    itemBuilder: (context, index) {
                      final gif =
                          homeCubit.trendingGifs[index].images?.fixedWidthSmall;

                      return ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            gif?.url ?? '',
                            fit: BoxFit.cover,
                          ));
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Expanded(
            child: TextField(
              cursorColor: Colors.black,
              cursorWidth: 1.2,
              decoration: InputDecoration(
                  hintText: 'Search Gifs', border: InputBorder.none),
            ),
          ),
          SizedBox(width: 10),
          Icon(Icons.search),
        ],
      ),
    );
  }

  Widget _buildBodyCanvas({required Size screenSize, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: screenSize.height,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: child,
    );
  }
}
