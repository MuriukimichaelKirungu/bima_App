import 'package:flutter/material.dart';
import '../../models/insurance_plan.dart';

class PaymentScreen extends StatelessWidget {
  final InsurancePlan plan;

  const PaymentScreen({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirm Payment")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("You're about to pay for:", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(
              plan.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(plan.description),
            const SizedBox(height: 20),
            Text("Type: ${plan.type}"),
            const SizedBox(height: 20),
            Text(
              "Amount: ₦${plan.price.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20, color: Colors.indigo),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Payment simulated: ₦${plan.price}")),
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.check_circle),
                label: const Text("Pay Now"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
