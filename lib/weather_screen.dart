import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additional_Item.dart';
import 'package:weather_app/hourly_card.dart';
import 'package:weather_app/main_card.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      const String apikey = "fd834ff020c870dba32a0a1d1ffbd4f6";
      const String cityName = "London";
      final result = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apikey"));

      final data = jsonDecode(result.body);

      if (data['cod'] != '200') {
        throw "Something went wrong :(";
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "weather app",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
          future: weather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final data = snapshot.data!;

            final Map<String, String> maincardData = {
              'icon':
                  "https://openweathermap.org/img/wn/${data['list'][0]['weather'][0]['icon']}@2x.png",
              'temp': data['list'][0]['main']['temp'].toString(),
              'desc': data['list'][0]['weather'][0]['description'].toString(),
              'wind speed': data['list'][0]['wind']['speed'].toString(),
              'humidity': data['list'][0]['main']['humidity'].toString(),
              'pressure': data['list'][0]['main']['pressure'].toString(),
            };

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // main card
                  SizedBox(
                    width: double.infinity,
                    child: MainCard(
                      icon: maincardData['icon']!,
                      weather: maincardData['desc']!,
                      temperature: maincardData['temp']!,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // hourly forecast section
                  const Text(
                    "weather Forecast",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return HourlyForecastWidget(
                            icon:
                                "https://openweathermap.org/img/wn/${data['list'][i + 1]['weather'][0]['icon']}.png",
                            temp:
                                data['list'][i + 1]['main']['temp'].toString(),
                            date: DateFormat.Hm().format(
                                DateTime.parse(data['list'][i + 1]['dt_txt'])),
                          );
                        }),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // additional info section
                  const Text(
                    "Additional Informationn",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalItem(
                        icon: Icons.water_drop,
                        typeOfInfo: 'humidity',
                        value: maincardData['humidity']!,
                      ),
                      AdditionalItem(
                        icon: Icons.air,
                        typeOfInfo: "Wind Speed",
                        value: maincardData['wind speed']!,
                      ),
                      AdditionalItem(
                        icon: Icons.beach_access,
                        typeOfInfo: "pressure",
                        value: maincardData['pressure']!,
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
