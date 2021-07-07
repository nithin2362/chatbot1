import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'coordinates.dart' as c;






Future<Weather> fetchWeather() async {


  var url = Uri.parse(
         "https://api.openweathermap.org/data/2.5/weather?lat=${12.00}&lon=${86.00}&appid=${c.apikey}");
         print(c.lat);
         print(c.lng);

  final response = await http.get(url);
      
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Weather {
  final  String temperature,mainweather,weatherdesc,city,country;


  Weather({
    this.country,
    this.city,
    this.temperature,
    this.mainweather,
    this.weatherdesc,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      country: json["sys"]["country"],
      city: json["city"],
      temperature: (json["main"]["temp"] - 273.15).toStringAsPrecision(4),
      mainweather: json["weather"][0]["main"],
      weatherdesc: json["weather"][0]["description"],
    );
  }
}







void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}





class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  
  
  Future<Weather> futureWeather;
  
  // Future<void> fetchData() async
  // {
    
  //   var url = Uri.parse(
  //       "https://api.openweathermap.org/data/2.5/weather?lat=${c.lat}&lon=${c.lng}&appid=${c.apikey}");
    
  //   if (response.statusCode == 200) {
  //     String data = response.body;
  //     var decoded = jsonDecode(data);
  //     temperature = (decoded["main"]["temp"] - 273.15).toStringAsPrecision(4);
  //     cityname = decoded["name"];
  //     mainweather = decoded["weather"][0]["main"];
  //     weatherdesc = decoded["weather"][0]["description"];
  //     country = decoded["sys"]["country"];
  //     print(country);
  //     print(cityname);

  // }
  // }
  

  
  // Future cityname;
  // Future mainweather;
  // Future weatherdesc;
  // Future temperature;
  // Future country,lat,lng;

  @override
  void initState()
  {
    super.initState();
    c.getpos();
    futureWeather = fetchWeather();
    
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: FutureBuilder<Weather>(

        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.country);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
            }     

    // By default, show a loading spinner.
    return CircularProgressIndicator();
  },
        ),
    );
  }
}
