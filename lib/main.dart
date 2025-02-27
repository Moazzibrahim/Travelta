import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/Auth/login_provider.dart';
import 'package:flutter_travelta/controllers/booking_engine_controller.dart';
import 'package:flutter_travelta/controllers/booking_list_controller.dart';
import 'package:flutter_travelta/controllers/costumer_controller.dart';
import 'package:flutter_travelta/controllers/leads/leads_provider.dart';
import 'package:flutter_travelta/controllers/manual_booking/data_list_provider.dart';
import 'package:flutter_travelta/controllers/request/request_provider.dart';
import 'package:flutter_travelta/controllers/supplier_controller.dart';
import 'package:flutter_travelta/view/screens/splash/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => LeadsProvider()),
        ChangeNotifierProvider(create: (_) => DataListProvider()),
        ChangeNotifierProvider(create: (_) => CustomerController()),
        ChangeNotifierProvider(create: (_) => SupplierController()),
        ChangeNotifierProvider(create: (_) => BookingEngineController()),
        ChangeNotifierProvider(create: (_) => BookingListController()),
        ChangeNotifierProvider(create: (_) => TravelProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      title: 'Travelta',
      home: const SplashScreen(),
    );
  }
}
