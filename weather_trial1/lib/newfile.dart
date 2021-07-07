import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert';
String apikey = "cefe38848825af88075921def3387a8b";
Future<Map> getpos() async
  {
    String lat,lng;
    Position p = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    lat = p.latitude.toString();
    lng = p.longitude.toString();
    return fetchData(lat,lng);
  }

Future<Map> fetchData(lat,lng) async
  {
    String temperature,cityname,country,mainweather,weatherdesc;
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lng}&appid=${apikey}");
    Response response = await get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var decoded = jsonDecode(data);
      temperature = (decoded["main"]["temp"] - 273.15).toStringAsPrecision(4);
      cityname = decoded["name"].toString();
      mainweather = decoded["weather"][0]["main"].toString();
      weatherdesc = decoded["weather"][0]["description"].toString();
      temperature = "${temperature} ℃";
      country = decoded["sys"]["country"].toString();
      return {"temp":temperature,"mw":mainweather,"wd":weatherdesc,"cty":cityname,"cntry":country};
    }
    else
    {
      print('Data not fetched !');
      return {"temp":"26.0","mw":"Sunny","wd":"Clear Sky","cty":"Chennai","cntry":"India"};
    }


  }