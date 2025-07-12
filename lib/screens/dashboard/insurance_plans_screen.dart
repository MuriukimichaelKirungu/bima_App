import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/insurance_provider.dart';
import '../../models/insurance_plan.dart';
import 'insurance_detail_screen.dart';

class InsurancePlansScreen extends StatelessWidget {
  const InsurancePlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InsuranceProvider>(context);
    final plans = provider.filteredPlans;

    return Scaffold(
      appBar: AppBar(title: const Text('Insurance Plans')),
      body: Column(
        children: [
          // 🔽 Dropdown Filter
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButton<String>(
              value: provider.selectedType,
              items: provider.planTypes.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  provider.filterByType(value);
                }
              },
              isExpanded: true,
            ),
          ),

          // 📝 List of Plans
          Expanded(
            child: ListView.builder(
              itemCount: plans.length,
              itemBuilder: (ctx, index) {
                final InsurancePlan plan = plans[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Image.network(plan.imageUrl, width: 50, height: 50),
                    title: Text(plan.name),
                    subtitle: Text(plan.description),
                    trailing: Text('₦${plan.price.toStringAsFixed(0)}'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => InsuranceDetailScreen(plan: plan),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
