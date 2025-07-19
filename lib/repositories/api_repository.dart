import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/apps/utils/const.dart';
import 'package:weather_app/models/weather_api.dart';

class ApiRepository {
  static Future<WeatherData> callApiGetWeather(Position? position) async {
    try {
      print(
        '[ApiRepository] callApiGetWeather: Bắt đầu gọi API với position: ' +
            position.toString(),
      );
      final dio = Dio();
      final url =
          'https://api.openweathermap.org/data/2.5/weather?lat=${position?.latitude}&lon=${position?.longitude}&units=metric&appid=${MyKey.apiToken}';
      print('[ApiRepository] callApiGetWeather: URL = $url');
      final res = await dio.get(url);
      print(
        '[ApiRepository] callApiGetWeather: Đã nhận response, statusCode = ${res.statusCode}',
      );
      print('[ApiRepository] callApiGetWeather: Response data = ${res.data}');
      return WeatherData.fromMap(res.data);
    } catch (e, stack) {
      print(
        '[ApiRepository] callApiGetWeather: Lỗi khi gọi API hoặc parse dữ liệu: ' +
            e.toString(),
      );
      print(stack);
      rethrow;
    }
  }

  static Future<List<WeatherDetail>> callApiGetWeatherDetail(
    Position? position,
  ) async {
    try {
      final dio = Dio();
      final res = await dio.get(
        'https://api.openweathermap.org/data/2.5/forecast?lat=${position?.latitude}&lon=${position?.longitude}&units=metric&appid=${MyKey.apiToken}',
      );
      List data = res.data['list'];
      List<WeatherDetail> result = List<WeatherDetail>.from(
        data.map((e) => WeatherDetail.fromMap(e)).toList(),
      );
      return result;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> callApiGetWeatherDetailByCity(
    String city,
  ) async {
    try {
      final dio = Dio();
      final url =
          'https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=${MyKey.apiToken}';
      print('[ApiRepository] callApiGetWeather: URL = $url');
      final res = await dio.get(url);
      String name = res.data['city']['name'];
      List data = res.data['list'];
      List<WeatherDetail> result = List<WeatherDetail>.from(
        data.map((e) => WeatherDetail.fromMap(e)).toList(),
      );
      return {
        'name': name,
        'details': result,
      };
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
