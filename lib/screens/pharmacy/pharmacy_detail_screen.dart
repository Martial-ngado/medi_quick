import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/pharmacy_provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/product_card.dart';

class PharmacyDetailScreen extends StatelessWidget {
  final String pharmacyId;

  const PharmacyDetailScreen({super.key, required this.pharmacyId});

  @override
  Widget build(BuildContext context) {
    final pharmacy = context.read<PharmacyProvider>().getPharmacyById(pharmacyId);

    if (pharmacy == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Pharmacie non trouvée')),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(pharmacy.name),
              background: Image.network(
                pharmacy.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Theme.of(context).colorScheme.primary,
                    child: const Icon(
                      Icons.local_pharmacy,
                      size: 80,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(context, pharmacy),
                  const SizedBox(height: 24),
                  Text(
                    'Produits disponibles',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              final products = provider.getProductsByPharmacy(pharmacyId);

              if (products.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('Aucun produit disponible'),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        onTap: () => context.push('/product/${product.id}'),
                      );
                    },
                    childCount: products.length,
                  ),
                ),
              );
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, pharmacy) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  pharmacy.isOpen ? Icons.check_circle : Icons.cancel,
                  color: pharmacy.isOpen ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  pharmacy.isOpen ? 'Ouvert' : 'Fermé',
                  style: TextStyle(
                    color: pharmacy.isOpen ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      pharmacy.rating.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 24),
            _buildInfoRow(
              Icons.access_time,
              'Horaires: ${pharmacy.openingHours} - ${pharmacy.closingHours}',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.location_on, pharmacy.address),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.phone, pharmacy.phone),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _makePhoneCall(pharmacy.phone),
                    icon: const Icon(Icons.phone),
                    label: const Text('Appeler'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _openMap(
                      pharmacy.latitude,
                      pharmacy.longitude,
                    ),
                    icon: const Icon(Icons.directions),
                    label: const Text('Itinéraire'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _openMap(double latitude, double longitude) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
