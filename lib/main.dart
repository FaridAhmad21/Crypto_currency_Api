import 'package:cryptotracker_with_api/models/local_storage.dart';
import 'package:cryptotracker_with_api/pages/homepage.dart';
import 'package:cryptotracker_with_api/provider/market_provider.dart';
import 'package:cryptotracker_with_api/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cryptotracker_with_api/constants/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String currentTheme = await LocalStorage.getTheme() ?? " light";
  runApp( MyApp(
    theme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;
  MyApp({required this.theme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MarketProvider>(
              create: (context) => MarketProvider(),
          ),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(theme),
          )
        ],
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, themeProvider, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: const HomePage(),
          );
        },),

    );

  }
}

