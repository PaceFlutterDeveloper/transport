import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transport_app/data/resource/remote/app_providers.dart';
import 'package:transport_app/presentation/pages/home/home_screen.dart';
import 'package:transport_app/presentation/pages/transport_screen.dart';

import '../presentation/pages/login/login_screen.dart';
import '../utils/constants/db_constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allProviders(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Transport',
          theme: ThemeData(
            textTheme: GoogleFonts.robotoTextTheme(),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(color: Colors.black),
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 0, 0, 0),
              background: Colors.white,
            ).copyWith(background: Colors.white),
          ),
          home: ValueListenableBuilder(
              valueListenable: Hive.box(tripDb).listenable(),
              builder: (BuildContext context, Box value, Widget? child) {
                if (value.get("logged") != null &&
                    value.get(tripId) == null &&
                    value.get(tripName) == null) {
                  return const TransportScreen();
                } else if (value.get(tripId) != null &&
                    value.get(tripName) != null &&
                    value.get("logged") != null) {
                  return const HomeScreen();
                } else {
                  return const LoginScreen();
                }
              })),
    );
  }
}
