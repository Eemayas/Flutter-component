// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_changer/theme_option_pages/provider.dart';
import './theme_option_pages/constant.dart';
import './theme_option_pages/theme_option_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  await themeProvider.loadSavedPreferences();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeProvider),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      child: const ThemeOptionsPage(),
      builder: (c, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.selectedThemeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: AppColors.getMaterialColorFromColor(themeProvider.selectedPrimaryColor),
            primaryColor: themeProvider.selectedPrimaryColor,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: AppColors.getMaterialColorFromColor(themeProvider.selectedPrimaryColor),
            primaryColor: themeProvider.selectedPrimaryColor,
          ),
          home: child,
        );
      },
    );
  }
}
