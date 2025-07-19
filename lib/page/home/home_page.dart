import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_api.dart';
import 'package:weather_app/page/home/widgets/home_detail_weather.dart';
import 'package:weather_app/page/home/widgets/home_location.dart';
import 'package:weather_app/page/home/widgets/home_temperature.dart';
import 'package:weather_app/page/home/widgets/home_weather_icon.dart';
import 'package:weather_app/providers/weather_api_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<WeatherApiProvider>().getWeatherCurrent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff1D6CF3), Color(0xff19D2FE)],
          ),
        ),
        child: SafeArea(
          child: FutureBuilder(
            future: context.read<WeatherApiProvider>().getWeatherCurrent(),
            initialData: null,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData) {
                return Container(child: Text('no data'));
              }

              WeatherData data = snapshot.data as WeatherData;

              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeWeatherIcon(nameIcon: data.weather[0].main),
                    HomeTemperature(temp: data.main.temp),
                    HomeLocation(nameLocation: data.name),
                    SizedBox(height: 40),
                    HomeDetailWeather(
                      windSpeed: data.wind.speed,
                      humidity: data.main.humidity,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
