import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthflex_giphy/controller/home_cubit/home_cubit.dart';
import 'package:helthflex_giphy/theme/theme.dart';
import 'pages/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HelthFlex Giphy App',
        theme: lightMode,
        darkTheme: darkMode,
        home: const HomePage(),
      ),
    );
  }
}
