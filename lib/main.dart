import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/presentation/pages/home_page.dart';
import 'package:tourism_app/presentation/pages/signup_page.dart';
import 'package:tourism_app/presentation/splash_screen.dart';
import 'package:tourism_app/providers/auth.dart';
import 'package:tourism_app/providers/category_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, fontFamily: 'AppFont'),

      locale: const Locale('ar', 'AE'),

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [Locale('ar', 'AE')],

      home: Consumer<Auth>(
        builder: (context, auth, child) {
          if (!auth.initialized) {
            return SplashScreen();
          }

          if (auth.authenticated) {
            return HomePage();
          } else {
            return SignupPage();
          }
        },
      ),
    );
  }
}
