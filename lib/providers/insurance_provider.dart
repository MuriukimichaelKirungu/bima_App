import 'package:flutter/foundation.dart';
import '../models/insurance_plan.dart';

class InsuranceProvider extends ChangeNotifier {
  final List<InsurancePlan> _plans = [
    InsurancePlan(
      id: 'plan1',
      name: 'Basic Health Plan',
      description: 'Affordable coverage for regular checkups and emergencies.',
      price: 5000.0,
      type: 'Health',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    InsurancePlan(
      id: 'plan2',
      name: 'Comprehensive Auto Insurance',
      description: 'Full coverage for accidents, theft, and damages.',
      price: 12000.0,
      type: 'Auto',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    InsurancePlan(
      id: 'plan3',
      name: 'Family Life Insurance',
      description: 'Secure your family’s future with long-term coverage.',
      price: 8000.0,
      type: 'Life',
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

//filter search results
  String _selectedType = 'All';

  String get selectedType => _selectedType;

  void filterByType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  List<InsurancePlan> get filteredPlans {
    if (_selectedType == 'All') return [..._plans];
    return _plans.where((p) => p.type == _selectedType).toList();
  }

  List<String> get planTypes {
    return ['All', ..._plans.map((p) => p.type).toSet()];
  }

//  FILTERING LOGIC ENDS HERE
}
