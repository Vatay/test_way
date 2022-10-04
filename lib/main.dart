import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ways/bloc/ways_bloc.dart';
import 'package:ways/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WaysBloc>(
      create: (context) => WaysBloc()..add(WaysInitialScreen()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ways',
        home: const HomeScreen(),
      ),
    );
  }
}
