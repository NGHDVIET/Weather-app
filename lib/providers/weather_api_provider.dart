import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_api.dart';
import 'package:weather_app/repositories/api_repository.dart';

class WeatherApiProvider extends ChangeNotifier {
  Position? position;
  String nameCity = 'Bien Hoa';

  updatePosition(Position positionCurrent) {
    print('[WeatherApiProvider] updatePosition: $positionCurrent');
    position = positionCurrent;
    notifyListeners();
    print('[WeatherApiProvider] updatePosition: notifyListeners called');
  }

  Future<WeatherData> getWeatherCurrent() async {
    print('[WeatherApiProvider] getWeatherCurrent: Bắt đầu gọi API');
    WeatherData result = await ApiRepository.callApiGetWeather(position);
    print('[WeatherApiProvider] getWeatherCurrent: Đã nhận dữ liệu từ API: ' + result.toString());
    nameCity = result.name;
    notifyListeners();
    print('[WeatherApiProvider] getWeatherCurrent: notifyListeners called');
    return result;
  }

  Future<List<WeatherDetail>> getWeatherDetail() async {
    print('[WeatherApiProvider] getWeatherDetail: Bắt đầu gọi API');
    List<WeatherDetail> result = await ApiRepository.callApiGetWeatherDetail(
      position,
    );
    print('[WeatherApiProvider] getWeatherDetail: Đã nhận dữ liệu từ API, length = ' + result.length.toString());
    return result;
  }

  Future<List<WeatherDetail>> getWeatherDetailByCity(String city) async {
    print('[WeatherApiProvider] getWeatherDetailByCity: Bắt đầu gọi API với city = $city');
    final response = await ApiRepository.callApiGetWeatherDetailByCity(city);
    final String name = response['name'];
    final List<WeatherDetail> result = response['details'];
    print('[WeatherApiProvider] getWeatherDetailByCity: Đã nhận dữ liệu từ API, length = ' + result.length.toString());
    nameCity = name;
    notifyListeners();
    print('[WeatherApiProvider] getWeatherDetailByCity: notifyListeners called');
    return result;
  }
}
