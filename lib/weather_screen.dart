import 'package:flutter/material.dart';
import 'services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? _weatherData;
  final TextEditingController _cityController = TextEditingController();

  Future<void> _getWeather() async {
    final city = _cityController.text.trim();
    if (city.isEmpty) return;

    final data = await _weatherService.fetchWeather(city);
    setState(() {
      _weatherData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Clima'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Ciudad',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _getWeather,
              child: const Text('Consultar Clima'),
            ),
            const SizedBox(height: 20),
            if (_weatherData != null)
              Card(
                color: Colors.lightBlue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Ciudad: ${_weatherData!['name']}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Temperatura: ${_weatherData!['main']['temp']} °C',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Descripción: ${_weatherData!['weather'][0]['description']}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Icon(
                        Icons.wb_sunny,
                        size: 50,
                        color: Colors.orangeAccent,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
