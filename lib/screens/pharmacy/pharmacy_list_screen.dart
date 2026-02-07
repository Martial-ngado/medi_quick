import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../providers/pharmacy_provider.dart';
import '../../widgets/pharmacy_card.dart';

class PharmacyListScreen extends StatefulWidget {
  const PharmacyListScreen({super.key});

  @override
  State<PharmacyListScreen> createState() => _PharmacyListScreenState();
}

class _PharmacyListScreenState extends State<PharmacyListScreen> {
  bool _showMap = false;
  bool _showOpenOnly = false;
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Pharmacies à Abidjan'),
        actions: [
          IconButton(
            icon: Icon(_showMap ? Icons.list : Icons.map),
            onPressed: () {
              setState(() => _showMap = !_showMap);
              if (_showMap) {
                _createMarkers();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Rechercher une pharmacie...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  onChanged: (value) {
                    context.read<PharmacyProvider>().searchPharmacies(value);
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    FilterChip(
                      label: const Text('Ouvertes maintenant'),
                      selected: _showOpenOnly,
                      onSelected: (selected) {
                        setState(() => _showOpenOnly = selected);
                        context
                            .read<PharmacyProvider>()
                            .filterByOpenStatus(selected);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: _showMap ? _buildMapView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildMapView() {
    return Consumer<PharmacyProvider>(
      builder: (context, provider, child) {
        return GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(5.3167, -4.0167), // Abidjan
            zoom: 12,
          ),
          markers: _markers,
          onMapCreated: (controller) {
            _mapController = controller;
            _createMarkers();
          },
        );
      },
    );
  }

  Widget _buildListView() {
    return Consumer<PharmacyProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.pharmacies.isEmpty) {
          return const Center(
            child: Text('Aucune pharmacie trouvée'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: provider.pharmacies.length,
          itemBuilder: (context, index) {
            final pharmacy = provider.pharmacies[index];
            return PharmacyCard(
              pharmacy: pharmacy,
              onTap: () => context.push('/pharmacy/${pharmacy.id}'),
            );
          },
        );
      },
    );
  }

  void _createMarkers() {
    final provider = context.read<PharmacyProvider>();
    _markers = provider.pharmacies.map((pharmacy) {
      return Marker(
        markerId: MarkerId(pharmacy.id),
        position: LatLng(pharmacy.latitude, pharmacy.longitude),
        infoWindow: InfoWindow(
          title: pharmacy.name,
          snippet: pharmacy.address,
          onTap: () => context.push('/pharmacy/${pharmacy.id}'),
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          pharmacy.isOpen
              ? BitmapDescriptor.hueGreen
              : BitmapDescriptor.hueRed,
        ),
      );
    }).toSet();
    setState(() {});
  }
}
