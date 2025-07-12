import 'package:flutter/material.dart';
import '../../models/insurance_plan.dart';
import '../payment/payment_screen.dart';


class InsuranceDetailScreen extends StatelessWidget {
  final InsurancePlan plan;

  const InsuranceDetailScreen({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plan.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(plan.imageUrl, width: 150, height: 150),
            ),
            const SizedBox(height: 20),
            Text(
              plan.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              plan.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.category, size: 20),
                const SizedBox(width: 8),
                Text(plan.type, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Price: ₦${plan.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.indigo,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PaymentScreen(plan: plan),
                    ),
                  );
                },

                icon: const Icon(Icons.payment),
                label: const Text("Buy Plan"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
