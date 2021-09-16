import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:untitled/models/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Update_Recipe extends StatefulWidget {
  const Update_Recipe({Key? key}) : super(key: key);

  @override
  _Update_RecipeState createState() => _Update_RecipeState();
}

class _Update_RecipeState extends State<Update_Recipe> {
  String fdcID = 'Unknown';
  String nutInfo = 'Unknown';
  String calories = 'Unknown';
  String barcodeScan = 'Unknown';
  String recipeName = '';
  String servingsNum = 'Unknown';
  String fin_al = '';

  var api_key = dotenv.env["API_KEY"];
  var fName = null;
  var cName = null;
  var sName = null;
  var totalCal = 0;

  final fireStore = FirebaseFirestore.instance;
  final textInput = TextEditingController();
  final servings = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('Update Recipe'),
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(onPressed: scanBarcode, icon: Icon(Icons.add_a_photo), label: Text('Scan Barcode'),)
        ]

      ),
      body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 15.0),
        TextFormField(
          // decoration: textInputDecoration.copyWith(hintText: 'Enter Recipe Name: '),
          controller: textInput,
          decoration:
          InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.send_and_archive),
              onPressed: () {
                recipeName = textInput.text.toString();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(content: Text('New Recipe Applied!'));
                  },
                );
                setState(() {
                });
              }

            ),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink, width: 2.0)),


        ).copyWith(hintText: 'Enter Recipe Name: '),
        ),
        SizedBox(height: 15.0),

        TextFormField(
          // decoration: textInputDecoration.copyWith(hintText: 'Enter Recipe Name: '),
          controller: servings,
          decoration:
          InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.send_and_archive),
              onPressed: () {
                servingsNum = servings.text.toString();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        content: Text('Number of Servings Applied!'));
                  },
                );
              }
            ),
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink, width: 2.0)),
          ).copyWith(hintText: 'Enter Number of Servings: '),
        ),

        Text(
            '\n\nbarcode number: $barcodeScan\n',
            style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          'Nutrition Info: $nutInfo\n',
           style: Theme.of(context).textTheme.headline6,
        ),
        // Text(
        //   'Servings: $servingsNum',
        //   style: Theme.of(context).textTheme.headline4,
        // ),
        Text(
            'Calories: $calories Kcal.\n',
            style: Theme.of(context).textTheme.headline6,
        ),

        RaisedButton(
            color: Colors.green[400],
            child: Text('Update Recipe', style: TextStyle(color: Colors.white),),
            onPressed: ()
            {
              updateData();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(content: Text('Recipe Updated!'));
                },
              );
            },

        ),
      ],
    ),
    ));
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
    var response = await http.get(Uri.parse('https://api.nal.usda.gov/fdc/v1/foods/search?query=$barcodeScan&api_key=' + api_key.toString()));
    var nut = jsonDecode(response.body);
    fdcID = nut['foods'][0]['fdcId'].toString();
    nutInfo = nut['foods'][0]['description'].toString();
    calories = nut['foods'][0]['foodNutrients'][3]['value'].toString();

    setState(() {});
  }

  Future<void> updateData() async {
    fireStore.collection(recipeName).doc(nutInfo).set(
        {
          "Product" : "$nutInfo",
          "Calories" : (int.parse(servingsNum)*int.parse(calories)).toString(),
          "FDC ID" : "$fdcID",
          "servings " : "$servingsNum"
        },
        SetOptions(merge: true)).then((_){
      print(recipeName);
    });
  }

}
