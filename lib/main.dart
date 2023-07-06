import 'package:crud_operation_dio/routes/routes.dart';
import 'package:crud_operation_dio/screens/get_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final kColor = ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent);
void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: kColor,
        scaffoldBackgroundColor: const Color.fromARGB(255, 207, 204, 204),
      ),
      routes: Routes.routes,
      home: const UsersScreen(),
    );
  }
}
