import 'dart:ffi';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';




const API_PREFIX = 'k7OIzZdhsCq7Ugqfl8kHX6XDrBjFFhvTY0PfDXkz';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/HomeScreen': (BuildContext context) => new MyApp()
    },
  ));
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }
  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('assets/splash.png'),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode Scanner',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Barcode Scanner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String fdcID = 'Unknown';
  String nutInfo = 'Unknown';
  String calories = 'Unknown';
  String barcodeScan = 'Unknown';
  String name = 'Taeyhon_Paik';

  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'barcode number: $barcodeScan'),
            Text(
              'Nutrition Info: $nutInfo',),
            Text(
              'FDC ID: $fdcID',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Calories: $calories Kcal.',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            icon: Icon(Icons.add),
            onPressed: scanBarcode,
            tooltip: 'barcode',
            label: Text('Scan Barcode')
          ),
          FloatingActionButton.extended(
            icon: Icon(Icons.add),
            onPressed: updateData,
            tooltip: 'update data',
            label: Text('Store Food'),
          ),
          FloatingActionButton.extended(
            icon: Icon(Icons.add),
            onPressed: delData,
            tooltip: 'get list',
            label: Text('Delete Stored Data'),
          )
      ]
      ),
    );
  }
  Future<void> scanBarcode() async {
    try {
      final barcodeScan = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );

      if (!mounted) return;

      setState(() {
        this.barcodeScan = barcodeScan;
      });
    } on PlatformException {
      barcodeScan = 'Failed to get platform version.';
    }
    getNutrition();
  }

  Future<void> getNutrition() async {
      var response = await http.get(Uri.parse('https://api.nal.usda.gov/fdc/v1/foods/search?query=$barcodeScan&api_key=' + API_PREFIX));
      var nut = jsonDecode(response.body);
      fdcID = nut['foods'][0]['fdcId'].toString();
      nutInfo = nut['foods'][0]['description'].toString();
      calories = nut['foods'][0]['foodNutrients'][3]['value'].toString();

      setState(() {});
    }

  Future<void> updateData() async {
    // fireStore.collection("user").add(
    //     {
    //       "Product" : "$nutInfo",
    //       "Calories" : "$calories kcal",
    //       "FDC ID" : "$fdcID"
    //     }).then((value){
    //   print(value.id);
    // });

    fireStore.collection(name).doc(nutInfo).set(
      {
        "Product" : "$nutInfo",
        "Calories" : "$calories kcal",
        "FDC ID" : "$fdcID"
      }).then((value){
          print(name);
      }
    );

    getList();
  }

  Future<void> getList() async {

    fireStore.collection(name).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  }


  Future<void> delData() async {
    fireStore.collection(name).doc(nutInfo).delete().then((_) {
    });
  }



  }