import 'package:flutter/material.dart';

class HourlyForecastWidget extends StatelessWidget {
  final String icon;
  final String date;
  final String temp;
  const HourlyForecastWidget(
      {super.key, required this.icon, required this.date, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 150,
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
        child: Column(
          children: [
            Text(
              date,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Image.network(
              icon,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              temp,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
