import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const StyleHubApp());
}

class StyleHubApp extends StatelessWidget {
  const StyleHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STYLE HUB',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5EFE7),
      ),
      home: const HomePage(),
    );
  }
}