import 'dart:ui';

import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  final String icon;
  final String weather;
  final String temperature;
  const MainCard({
    super.key,
    required this.icon,
    required this.temperature,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  temperature,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                Image.network(
                  icon,
                ),
                // Icon(
                //   Image.network(src),
                //   size: 64,
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                Text(
                  weather,
                  style: const TextStyle(
                    fontSize: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
