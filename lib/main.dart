import 'package:contact_diary/controller/contact_provider.dart';
import 'package:contact_diary/controller/counter_provider.dart';
import 'package:contact_diary/login_page.dart';
import 'package:contact_diary/controller/theme_provider.dart';
import 'package:contact_diary/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => ContactProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: Provider.of<ThemeProvider>(context).getThemeMode(),
          home: splashscreen(),
        );
      },
    );
  }
}
