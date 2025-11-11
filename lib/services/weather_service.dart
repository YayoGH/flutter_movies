import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'a78e4d06bb6bdf420fdd8ddd81062219';

  // Método para obtener el clima por nombre de ciudad
  Future<Map<String, dynamic>?> fetchWeather(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=es',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error en la petición: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error al conectar con la API: $e');
      return null;
    }
  }
}
