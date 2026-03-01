import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    const borderColor = Colors.white;

    return TextField(
      decoration: InputDecoration(
        hintText: 'Rechercher un médicament...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey,),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: borderColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: borderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: borderColor, width: 2),
        ),
      ),
      onTap: () => context.push('/products'),
      readOnly: true,
    );
  }
}