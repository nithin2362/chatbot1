import 'dart:async';
import 'package:geolocator/geolocator.dart';


var lat,lng;
const String apikey = "482f6c8eda24fe147364858dd14a0c24";

Future<Position> getpos() async
  {
  
    Position p = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    return p;
    
  }