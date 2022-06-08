import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/weather.dart';

class HttpHelper {
  // https://api.openweathermap.org/data/2.5/weather?q=Pretoria&appid=1c844ce459cc0e4387b59eaa4a687622
  final String authority = 'api.openweathermap.org';
  final String path = 'data/2.5/weather';
  final String apiKey = '1c844ce459cc0e4387b59eaa4a687622';

  Future<Weather> getWeather(String location) async {
    Map<String, dynamic> parameters = {'q': location, 'appId': apiKey};
    Uri uri = Uri.https(authority, path, parameters);
    http.Response result = await http.get(uri);
    Map<String, dynamic> data = json.decode(result.body);
    print(data);
    Weather weather = Weather.fromJson(data);
    return weather;
  }
}