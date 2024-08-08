class Weather {
  String? cityName;
  double? temperature;
  String? description;
  double? feelsLike;
  int? humidity;
  int? visibility;
  double? windSpeed;
  String? sunrise;
  String? sunset;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    // Helper function to format Unix timestamp to human-readable time
    String formatTime(int timestamp) {
      final dateTime =
          DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }

    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'],
      description: json['weather'][0]['description'],
      feelsLike: json['main']['feels_like'],
      humidity: json['main']['humidity'],
      visibility: json['visibility'],
      windSpeed: json['wind']['speed'],
      sunrise: formatTime(json['sys']['sunrise']),
      sunset: formatTime(json['sys']['sunset']),
    );
  }
}
