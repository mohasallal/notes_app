import 'package:flutter/material.dart';
import 'package:test_final/pages/home_page.dart';
import 'package:test_final/services/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await IsarService.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
