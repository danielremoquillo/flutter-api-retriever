import 'package:flutter/material.dart';
import 'package:flutter_api_retriever/providers/photo_drawer.dart';
import 'package:flutter_api_retriever/providers/photos.dart';
import 'package:flutter_api_retriever/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PhotosProvider()),
      ChangeNotifierProvider(create: (_) => DrawerProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Isolate Demo';

    return const MaterialApp(
      title: appTitle,
      home: HomeScreen(),
    );
  }
}
