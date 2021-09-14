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
  String recipeName = 'Taeyhon_Paik';
  String servingsNum = 'Unknown';

  final fireStore = FirebaseFirestore.instance;



  final textInput = TextEditingController();
  final servings = TextEditingController();
  @override
  void dispose() {
    textInput.dispose();
    servings.dispose();
    super.dispose();
  }



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
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Enter Recipe Name: ',
              style: Theme.of(context).textTheme.headline4,),
            TextField(controller: textInput,),
            Text('\n\nEnter Servings For Food: ',
              style: Theme.of(context).textTheme.headline4,),
            TextField(controller: servings,),
            Text(
              '\n\n\nbarcode number: $barcodeScan'),
            Text(
              'Nutrition Info: $nutInfo',),
            Text(
              'Servings: $servingsNum',
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
            icon: Icon(Icons.add_a_photo),
            onPressed: scanBarcode,
            label: Text('Scan Barcode')
          ),
          FloatingActionButton.extended(
            icon: Icon(Icons.system_update_tv),
            onPressed: updateData,
            label: Text('Store Food'),
          ),

          FloatingActionButton.extended(
            icon: Icon(Icons.delete_forever),
            onPressed: delData,
            label: Text('Delete Stored Data'),
          ),
          FloatingActionButton.extended(
            icon: Icon(Icons.text_fields),
            onPressed: () {
              recipeName = textInput.text.toString();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(content: Text('New Recipe Applied!'));
                },
              );
            },
            label: Text('New Recipe Name'),
          ),
          FloatingActionButton.extended(
            icon: Icon(Icons.food_bank),
            onPressed: () {
              servingsNum = servings.text.toString();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(content: Text('New Recipe Applied!'));
                },
              );
            },
            label: Text('Servings for Food')),
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

    fireStore.collection(recipeName).doc(nutInfo).set(
      {
        "Product" : "$nutInfo",
        "Calories" : "$calories kcal",
        "FDC ID" : "$fdcID"
      },
        SetOptions(merge: true)).then((_){
          print(recipeName);
      });

    getList();
  }

  Future<void> getList() async {

    fireStore.collection(recipeName).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  }


  Future<void> delData() async {
    fireStore.collection(recipeName).doc(nutInfo).delete().then((_) {
    });
  }

  }