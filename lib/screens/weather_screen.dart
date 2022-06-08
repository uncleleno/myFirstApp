import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:global_fitness/data/http_helper.dart';
import 'package:global_fitness/data/weather.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';



class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenStateState createState() => _WeatherScreenStateState();
}

class _WeatherScreenStateState extends State<WeatherScreen> {
  final TextEditingController txtPlace = TextEditingController();
  // void statefulMapController;
  final MapController _mapController = MapController();
  Location location = Location();

  double zoom = 15;
  double latPerson = -25.76504;
  double lngPerson = 28.27932;
  LatLng center = LatLng(-25.76504, 28.27932);

  Weather result = Weather('','', 0, 0, 0, 0, 0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Padding(
                padding: EdgeInsets.all(16),
            child: TextField(
              controller: txtPlace,
              decoration: InputDecoration(
                hintText: 'Enter a City',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: getData,
                )
              )
            )
          ),
            weatherRow('Place: ', result.name),
            weatherRow('Description: ', result.description),
            weatherRow('Temperature: ', result.temperature.toStringAsFixed(2)),
            weatherRow('Perceived: ', result.perceived.toStringAsFixed(2)),
            weatherRow('Pressure: ', result.pressure.toStringAsFixed(0)),
            weatherRow('Humidity: ', result.humidity.toStringAsFixed(0)),
            weatherRow('Latitude: ', result.latitude.toStringAsFixed(4)),     //New lat
            weatherRow('Longitude: ', result.longitude.toStringAsFixed(4)),  // New long
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  minZoom: 11.5,
                  maxZoom: 18.0,
                  //center: center,
                  zoom: zoom,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: [
                      'a',
                      'b',
                      'c',
                    ],
                  ),

                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: center,
                        builder: (ctx) =>
                          Container(
                            child: const Icon(Icons.location_on, size: 50.0,) ,
                          ),
                        ),
                    ],
                  ),
                ],

              ),
            ),
          ],
        ),
      )
    );

  }
  Future getData() async {
    HttpHelper helper = HttpHelper();
    result = await helper.getWeather(txtPlace.text);
    setState(() {
      latPerson = result.latitude;
      lngPerson = result.longitude;
      center = LatLng(latPerson, lngPerson);
      _mapController.move(center, zoom);
    });
    }
    Widget weatherRow(String label, String value) {
    Widget row = Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).hintColor,
               ))),
          Expanded(
            flex: 4,
              child: Text(value,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ))),
      ]));
    return row;
    }
  }
