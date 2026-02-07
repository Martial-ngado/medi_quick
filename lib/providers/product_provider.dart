import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String? _selectedCategory;

  List<Product> get products => _filteredProducts;
  bool get isLoading => _isLoading;
  List<String> get categories => [
        'Tous',
        'Antibiotiques',
        'Antidouleur',
        'Vitamines',
        'Dermatologie',
        'Cardiologie',
        'Diabète',
      ];

  ProductProvider() {
    loadProducts();
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _products = [
        Product(
          id: '1',
          name: 'Paracétamol 500mg',
          description: 'Antidouleur et antipyrétique',
          price: 1500,
          category: 'Antidouleur',
          imageUrl: 'https://via.placeholder.com/200',
          requiresPrescription: false,
          stock: 150,
          pharmacyId: '1',
          manufacturer: 'Pharma CI',
        ),
        Product(
          id: '2',
          name: 'Amoxicilline 500mg',
          description: 'Antibiotique à large spectre',
          price: 3500,
          category: 'Antibiotiques',
          imageUrl: 'https://via.placeholder.com/200',
          requiresPrescription: true,
          stock: 80,
          pharmacyId: '1',
          manufacturer: 'Medic Plus',
        ),
        Product(
          id: '3',
          name: 'Vitamine C 1000mg',
          description: 'Complément alimentaire',
          price: 2500,
          category: 'Vitamines',
          imageUrl: 'https://via.placeholder.com/200',
          requiresPrescription: false,
          stock: 200,
          pharmacyId: '2',
          manufacturer: 'VitaHealth',
        ),
        Product(
          id: '4',
          name: 'Ibuprofène 400mg',
          description: 'Anti-inflammatoire',
          price: 2000,
          category: 'Antidouleur',
          imageUrl: 'https://via.placeholder.com/200',
          requiresPrescription: false,
          stock: 120,
          pharmacyId: '2',
          manufacturer: 'Pharma CI',
        ),
        Product(
          id: '5',
          name: 'Aspirine 100mg',
          description: 'Antiagrégant plaquettaire',
          price: 1800,
          category: 'Cardiologie',
          imageUrl: 'https://via.placeholder.com/200',
          requiresPrescription: false,
          stock: 100,
          pharmacyId: '3',
          manufacturer: 'CardioMed',
        ),
        Product(
          id: '6',
          name: 'Metformine 850mg',
          description: 'Traitement du diabète type 2',
          price: 4500,
          category: 'Diabète',
          imageUrl: 'https://via.placeholder.com/200',
          requiresPrescription: true,
          stock: 60,
          pharmacyId: '4',
          manufacturer: 'DiabetCare',
        ),
        Product(
          id: '7',
          name: 'Crème Hydratante',
          description: 'Soin pour peau sèche',
          price: 3000,
          category: 'Dermatologie',
          imageUrl: 'https://via.placeholder.com/200',
          requiresPrescription: false,
          stock: 90,
          pharmacyId: '5',
          manufacturer: 'DermaSoin',
        ),
        Product(
          id: '8',
          name: 'Multivitamines',
          description: 'Complexe vitaminique complet',
          price: 5000,
          category: 'Vitamines',
          imageUrl: 'https://via.placeholder.com/200',
          requiresPrescription: false,
          stock: 75,
          pharmacyId: '1',
          manufacturer: 'VitaHealth',
        ),
      ];

      _filteredProducts = _products;
    } catch (e) {
      debugPrint('Error loading products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchProducts(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
  }

  void filterByCategory(String? category) {
    _selectedCategory = (category == 'Tous') ? null : category;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredProducts = _products.where((product) {
      final matchesSearch = _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery) ||
          product.description.toLowerCase().contains(_searchQuery);

      final matchesCategory = _selectedCategory == null ||
          product.category == _selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    notifyListeners();
  }

  List<Product> getProductsByPharmacy(String pharmacyId) {
    return _products.where((p) => p.pharmacyId == pharmacyId).toList();
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
