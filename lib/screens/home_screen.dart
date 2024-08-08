import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 41, 56),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 8, 41, 56),
        title: Text("Weather App", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: Column(
              children: [
                TextField(
                  controller: _cityController,
                  style: TextStyle(
                      color: Colors.white), // TextField input text color
                  decoration: InputDecoration(
                    labelText: "City",
                    labelStyle: TextStyle(color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {
                        final city = _cityController.text;
                        if (city.isNotEmpty) {
                          context
                              .read<WeatherProvider>()
                              .fetchWeather(cityName: city);
                        }
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: Colors.white, // Border color
                        width: 2.0, // Border width
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: Colors.blue, // Border color when focused
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Consumer<WeatherProvider>(
                  builder: (context, weatherProvider, child) {
                    if (weatherProvider.isLoading) {
                      return CircularProgressIndicator();
                    } else if (weatherProvider.weather != null) {
                      final weather = weatherProvider.weather!;
                      final temperature = weather.temperature ?? 0;
                      String imagePath;
                      if (temperature > 40) {
                        imagePath = 'lib/img/hot.png';
                      } else if (temperature > 20) {
                        imagePath = 'lib/img/cloud.png';
                      } else {
                        imagePath = 'lib/img/cold.png';
                      }

                      return Column(
                        children: [
                          Image.asset(imagePath, height: 100, width: 100),
                          SizedBox(height: 16.0),
                          Text("Weather in ${weather.cityName}"),
                          Text("${weather.temperature}°C"),
                          Text(weather.description ?? 'No description'),
                          SizedBox(height: 16.0),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              _buildWeatherDetailItem(
                                imagePath: 'lib/img/feels.png',
                                label: 'Feels Like',
                                value: '${weather.feelsLike}°C',
                              ),
                              _buildWeatherDetailItem(
                                imagePath: 'lib/img/humidity.png',
                                label: 'Humidity',
                                value: '${weather.humidity}%',
                              ),
                              _buildWeatherDetailItem(
                                imagePath: 'lib/img/speed.png',
                                label: 'Wind Speed',
                                value: '${weather.windSpeed} km/h',
                              ),
                              _buildWeatherDetailItem(
                                imagePath: 'lib/img/sun_rise.png',
                                label: 'Sunrise',
                                value: weather.sunrise ?? 'N/A',
                              ),
                              _buildWeatherDetailItem(
                                imagePath: 'lib/img/sunset.png',
                                label: 'Sunset',
                                value: weather.sunset ?? 'N/A',
                              ),
                              _buildWeatherDetailItem(
                                imagePath: 'lib/img/visibility.png',
                                label: 'Visibility',
                                value: '${weather.visibility} m',
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Text("No weather data available");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherDetailItem(
      {required String imagePath,
      required String label,
      required String value}) {
    return Column(
      children: [
        Image.asset(imagePath, height: 50, width: 50),
        SizedBox(height: 8.0),
        Text(label),
        SizedBox(height: 4.0),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
