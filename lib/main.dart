import 'package:bima/providers/auth_provider.dart';
import 'package:bima/screens/auth/auth_gate.dart';
import 'package:bima/screens/auth/login_screen.dart';
import 'package:bima/screens/auth/register_screen.dart';
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
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Future: Add AuthProvider here when you implement auth
      ],
      child: MaterialApp(
        title: 'Bima App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            bodyMedium: TextStyle(fontSize: 16),
          ),
        ),

        home: const AuthGate(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/dashboard': (context) => const InsurancePlansScreen(),
        },

      ),
    );
  }
}
