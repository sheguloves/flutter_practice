import 'package:flutter/material.dart';
import 'package:note_demo/components/home_page.dart';
import 'package:note_demo/models/global_context.dart';
import 'package:note_demo/models/notes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GlobalContext()),
        // ChangeNotifierProvider(create: (context) => Notes()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notebook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Consumer<GlobalContext>(
        builder: (context, globalContext, child) {
          return HomePage(showDelete: globalContext.showDelete);
        },
      ),
    );
  }
}

