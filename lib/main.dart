import 'package:flutter/material.dart';
import 'package:range_indicators/logic/range_notifier.dart';
import 'package:range_indicators/ui/home_screen.dart';

import 'data/api_service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
