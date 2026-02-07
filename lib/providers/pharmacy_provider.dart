import 'package:flutter/foundation.dart';
import '../models/pharmacy.dart';

class PharmacyProvider with ChangeNotifier {
  List<Pharmacy> _pharmacies = [];
  List<Pharmacy> _filteredPharmacies = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<Pharmacy> get pharmacies => _filteredPharmacies;
  bool get isLoading => _isLoading;
  List<Pharmacy> get openPharmacies => 
      _filteredPharmacies.where((p) => p.isOpen).toList();

  PharmacyProvider() {
    loadPharmacies();
  }

  Future<void> loadPharmacies() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Données de démonstration pour Abidjan
      await Future.delayed(const Duration(seconds: 1));
      _pharmacies = [
        Pharmacy(
          id: '1',
          name: 'Pharmacie du Plateau',
          address: 'Boulevard de la République, Plateau, Abidjan',
          latitude: 5.3167,
          longitude: -4.0167,
          phone: '+225 27 20 21 00 00',
          isOpen: true,
          openingHours: '08:00',
          closingHours: '20:00',
          rating: 4.5,
          imageUrl: 'https://via.placeholder.com/300x200',
        ),
        Pharmacy(
          id: '2',
          name: 'Pharmacie Cocody',
          address: 'Cocody, Abidjan',
          latitude: 5.3600,
          longitude: -3.9800,
          phone: '+225 27 22 44 00 00',
          isOpen: true,
          openingHours: '07:30',
          closingHours: '21:00',
          rating: 4.8,
          imageUrl: 'https://via.placeholder.com/300x200',
        ),
        Pharmacy(
          id: '3',
          name: 'Pharmacie Marcory',
          address: 'Marcory Zone 4, Abidjan',
          latitude: 5.2800,
          longitude: -3.9900,
          phone: '+225 27 21 35 00 00',
          isOpen: false,
          openingHours: '08:00',
          closingHours: '19:00',
          rating: 4.2,
          imageUrl: 'https://via.placeholder.com/300x200',
        ),
        Pharmacy(
          id: '4',
          name: 'Pharmacie Treichville',
          address: 'Treichville, Abidjan',
          latitude: 5.2900,
          longitude: -4.0200,
          phone: '+225 27 21 24 00 00',
          isOpen: true,
          openingHours: '08:00',
          closingHours: '20:00',
          rating: 4.3,
          imageUrl: 'https://via.placeholder.com/300x200',
        ),
        Pharmacy(
          id: '5',
          name: 'Pharmacie Yopougon',
          address: 'Yopougon, Abidjan',
          latitude: 5.3400,
          longitude: -4.0900,
          phone: '+225 27 23 45 00 00',
          isOpen: true,
          openingHours: '07:00',
          closingHours: '22:00',
          rating: 4.6,
          imageUrl: 'https://via.placeholder.com/300x200',
        ),
      ];

      _filteredPharmacies = _pharmacies;
    } catch (e) {
      debugPrint('Error loading pharmacies: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchPharmacies(String query) {
    _searchQuery = query.toLowerCase();
    
    if (_searchQuery.isEmpty) {
      _filteredPharmacies = _pharmacies;
    } else {
      _filteredPharmacies = _pharmacies.where((pharmacy) {
        return pharmacy.name.toLowerCase().contains(_searchQuery) ||
               pharmacy.address.toLowerCase().contains(_searchQuery);
      }).toList();
    }
    
    notifyListeners();
  }

  void filterByOpenStatus(bool openOnly) {
    if (openOnly) {
      _filteredPharmacies = _pharmacies.where((p) => p.isOpen).toList();
    } else {
      _filteredPharmacies = _pharmacies;
    }
    notifyListeners();
  }

  Pharmacy? getPharmacyById(String id) {
    try {
      return _pharmacies.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
