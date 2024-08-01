import 'package:flutter/material.dart';

class AdditionalInfoCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final String value;
  const AdditionalInfoCard(
      {super.key, required this.name, required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Icon(
            icon,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
