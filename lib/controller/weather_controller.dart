import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:weather/model/weather_response_model.dart';
import 'package:weather_location/services/weather_service.dart';
import 'package:weather_location/model/weather_response_model.dart';

class WeatherController extends ChangeNotifier
{
  WeatherResponseModel?weatherResponseModel;
  bool isLoding=false;
Future<void> getCurrentWeather() async{
  isLoding=true;
notifyListeners();
WeatherService service=WeatherService();
Position? position = await _getCurrentLocation();


//weatherResponseModel=await service.getCurrentWeatherService("9.931233", "76.267303");
//weatherResponseModel=await service.getCurrentWeatherService(position.latitude,position.longitude);

//log(weatherResponseModel.toString());
//=false;
//notifyListeners();
//}
if (position != null) {
     // WeatherService service = WeatherService();
      weatherResponseModel = await service.getCurrentWeatherService(position.latitude.toString(), position.longitude.toString());
      log(weatherResponseModel.toString());
    } else {
      log('Failed to get current location');
    }

    isLoding = false;
    notifyListeners();

  
}
}
Future<Position?> _getCurrentLocation() async {
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
}