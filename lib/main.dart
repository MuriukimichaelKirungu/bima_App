import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/insurance_provider.dart';
import 'screens/dashboard/insurance_plans_screen.dart';

void main() {
  runApp(const BimaApp());
}

class BimaApp extends StatelessWidget {
  const BimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InsuranceProvider()),
      ],
      child: MaterialApp(
        title: 'Bima App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const InsurancePlansScreen(),
      ),
    );
  }
}
