import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      authProvider.userName?[0].toUpperCase() ?? 'U',
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    authProvider.userName ?? 'Utilisateur',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    authProvider.userEmail ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Paramètres',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 8),
          _buildMenuItem(
            context,
            icon: Icons.shopping_bag,
            title: 'Mes commandes',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fonctionnalité en cours de développement'),
                ),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.location_on,
            title: 'Mes adresses',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fonctionnalité en cours de développement'),
                ),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.payment,
            title: 'Moyens de paiement',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fonctionnalité en cours de développement'),
                ),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.notifications,
            title: 'Notifications',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fonctionnalité en cours de développement'),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Support',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: 8),
          _buildMenuItem(
            context,
            icon: Icons.help,
            title: 'Centre d\'aide',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fonctionnalité en cours de développement'),
                ),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.info,
            title: 'À propos',
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Pharmacy App',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2025 Pharmacy App',
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Application de pharmacie pour trouver et commander vos médicaments à Abidjan.',
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          _buildMenuItem(
            context,
            icon: Icons.logout,
            title: 'Se déconnecter',
            textColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Déconnexion'),
                  content: const Text(
                    'Êtes-vous sûr de vouloir vous déconnecter ?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Annuler'),
                    ),
                    TextButton(
                      onPressed: () {
                        authProvider.logout();
                        Navigator.pop(context);
                        context.go('/login');
                      },
                      child: const Text(
                        'Déconnexion',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: textColor),
        title: Text(
          title,
          style: TextStyle(color: textColor),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
