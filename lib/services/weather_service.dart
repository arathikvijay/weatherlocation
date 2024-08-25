import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:weather_location/model/weather_response_model.dart';
import 'package:weather_location/utils/const.dart';
//import 'package:geolocator/geolocator.dart';


class WeatherService{
  
Future <WeatherResponseModel?>getCurrentWeatherService(String lat,String log) async{
  //final baseurl=Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$log&appid=$apikey");
  //final baseurl=Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=9.931233&lon=76.267303&appid=$apikey");
  //final position = await _getCurrentLocation();
  final baseurl=Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$log&appid=$apikey");
  try{
    //if(position==null)return;

     final response=await http.get(baseurl);
     if(response.statusCode==200||response.statusCode==201)
     {
       //print("200 works");
       print(response.body.toString());
      final json=jsonDecode(response.body);
      final data=WeatherResponseModel.fromJson(json);
      //print("After parcing data");
      print(data.toString());
      return data;
     }
     else{
       //print("StatusCode :- ${response.statusCode} Body ${response.body}");
      return null;
     }
  }catch (e) {
    
    print(e.toString());
  }
  return null;
  }
  
  }
  /*Future<Position?> _getCurrentLocation() async {
  final hasPermission = await _handleLocationPermission();
  if (!hasPermission) return null;

  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

Future<bool> _handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return false;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should display an explanation as to why it
      // needs this permission/purpose. For this, please read
      // the below link and follow the Android Guideline's
      // implementation).
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return false;
  }

  return true;
}*/
 

