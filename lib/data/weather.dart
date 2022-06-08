class Weather{
  String name = '';
  String description = '';
  double latitude = 0;
  double longitude = 0;
  double temperature = 0;
  double perceived = 0;
  int pressure = 0;
  int humidity = 0;

  Weather(this.name, this.description, this.temperature,
      this.perceived, this.pressure, this.humidity, this.latitude, this.longitude);

      Weather.fromJson(Map<String, dynamic> weatherMap) {
      this.name = weatherMap['name']?? '';
      //this.temperature = (weatherMap['main']['temp'] * (9/5) - 459.67) ?? 0;
      this.temperature = (weatherMap['main']['temp'] - 273.15) ?? 0;
      this.perceived = (weatherMap['main']['feels_like'] - 273.15)?? 0;
      this.pressure = weatherMap['main']['pressure'] ?? 0;
      this.humidity = weatherMap['main']['humidity'] ?? 0;
      this.description = weatherMap['weather'][0]['main']?? '';
      this.latitude = (weatherMap['coord']['lat']) ?? 0;
      this.longitude = (weatherMap['coord']['lon']) ?? 0;

  }

}