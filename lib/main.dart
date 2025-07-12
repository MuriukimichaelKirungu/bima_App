import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'providers/insurance_provider.dart';
import 'screens/dashboard/insurance_plans_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase using the google-services.json
  await Firebase.initializeApp();

  runApp(const BimaApp());
}

class BimaApp extends StatelessWidget {
  const BimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InsuranceProvider()),
        // Future: Add AuthProvider here when you implement auth
      ],
      child: MaterialApp(
        title: 'Bima App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
        ),
        home: const InsurancePlansScreen(),
        // TODO: Add routes when you build login, register, detail, etc.
      ),
    );
  }
}
