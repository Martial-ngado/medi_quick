import 'package:flutter/material.dart';

class OptionconnectCard extends StatelessWidget {
  final String image;
  final VoidCallback? onTap;

  const OptionconnectCard({
    super.key,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),

        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: 
            Image.asset(
              image,
              height: 24,
              width: 24,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported, size: 24), // ✅ fallback if image not found
            ),
            
            
          
        ),
      ),
    );
  }
}