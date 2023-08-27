import 'package:flutter/material.dart';

class AdditionalItem extends StatelessWidget {
  final IconData icon;
  final String typeOfInfo;
  final String value;
  const AdditionalItem({
    super.key,
    required this.icon,
    required this.typeOfInfo,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          typeOfInfo,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white54),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    );
  }
}
