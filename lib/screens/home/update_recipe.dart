import 'package:flutter/material.dart';
import 'package:untitled/shared/constants.dart';

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
  var fName = null;
  var cName = null;
  var sName = null;
  String fin_al = '';

  var totalCal = 0;

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

      ),
      body: Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 15.0),
        TextFormField(
            obscureText: true,
            decoration: textInputDecoration.copyWith(hintText: 'Enter Recipe Name: '),
            controller: textInput,
        ),
        SizedBox(height: 15.0),

        TextFormField(
          obscureText: true,
          decoration: textInputDecoration.copyWith(hintText: 'Enter Servings For Food: '),
          controller: servings,
        ),



        Text(
            '\n\nbarcode number: $barcodeScan'),
        Text(
          'Nutrition Info: $nutInfo',),
        // Text(
        //   'Servings: $servingsNum',
        //   style: Theme.of(context).textTheme.headline4,
        // ),
        Text(
            'Calories: $calories Kcal.\n\n'
        ),
        Text(
            'Fetch Recipe Result for "$recipeName": \n$fin_al'
        ),
        Text(
            'Total Calories for "$recipeName": \n$totalCal kcal'
        )
      ],
    ),
    ));
  }
}
