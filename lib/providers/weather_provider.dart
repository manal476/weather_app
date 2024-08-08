import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherServices _weatherServices = WeatherServices();
  Weather? _weather;
  bool _isLoading = false;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather({required String cityName}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _weather = await _weatherServices.fetchWeather(cityName: cityName);
      if (_weather == null) {
        print('No weather data returned');
      }
    } catch (err) {
      _weather = null;
      print('Error fetching weather: $err');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
