import 'package:weather_provider_refactor/exceptions/weather_exception.dart';
import 'package:weather_provider_refactor/models/custom_error.dart';
import 'package:weather_provider_refactor/models/weather.dart';
import 'package:weather_provider_refactor/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiservices weatherApiservices;

  WeatherRepository({
    required this.weatherApiservices,
  });

  Future<Weather> fetchWeather(String city) async {
    try {
      final int woeid = await weatherApiservices.getWoeid(city);
      print('woeid: $woeid');

      final Weather weather = await weatherApiservices.getWeather(woeid);
      print('weather: $weather');

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}