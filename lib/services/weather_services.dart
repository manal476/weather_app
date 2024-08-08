import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherServices {
  final Dio _dio = Dio();
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String _apiKey = '39d0a54d2e44fba99b4d719ac0ca8223';

  Future<Weather?> fetchWeather({required String cityName}) async {
    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: {
          'q': cityName,
          'appid': _apiKey,
          'units': 'metric',
        },
      );

      //print('Response: ${response.data}');

      if (response.statusCode == 200) {
        print('Response: ${response.data}');
        return Weather.fromJson(response.data);
      } else {
        throw Exception('faild to load weather data');
      }
    } catch (err) {
      print('Error: $err');
      return null;
    }
  }
}
