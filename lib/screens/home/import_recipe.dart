import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Import_Recipe extends StatefulWidget {
  const Import_Recipe({Key? key}) : super(key: key);

  @override
  _Import_RecipeState createState() => _Import_RecipeState();
}

class _Import_RecipeState extends State<Import_Recipe> {
  String fdcID = 'Unknown';
  String nutInfo = 'Unknown';
  String calories = 'Unknown';
  String barcodeScan = 'Unknown';
  String recipeName = '';
  String servingsNum = 'Unknown';
  String fin_al = '';

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
          title: Text('Import Recipe'),
          backgroundColor: Colors.green[400],
          elevation: 0.0,

        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 15.0),
              TextFormField(
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
                      }

                  ),
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink, width: 2.0)),


                ).copyWith(hintText: 'Enter Recipe Name: '),
              ),

              Text(
                  '\n\n\n\nFetch Recipe Result for "$recipeName": \n$fin_al',
                  // style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                  'Total Calories for "$recipeName": \n$totalCal kcal\n\n\n\n',
                  style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          RaisedButton(
            color: Colors.green[400],
            child: Text('Import Recipe', style: TextStyle(color: Colors.white),),
            onPressed: getList,

          ),
          RaisedButton(
            color: Colors.green[400],
            child: Text('Delete Recipe', style: TextStyle(color: Colors.white),),
            onPressed: delData,

          ),

        ]
      ),
    );
  }

  Future<void> getList() async {

    fireStore.collection(recipeName).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        fName = result.data()['Product'];
        sName = result.data()['servings '];
        cName = result.data()['Calories'];
        fin_al += '$fName  :  Servings: $sName  :  $cName kcal\n';

        totalCal += int.parse(cName);

      });
    });

    setState(() {});
  }


  Future<void> delData() async {
    // fireStore.collection(recipeName).doc(nutInfo).delete().then((_) {});
    fin_al = '';
    totalCal = 0;
  }

}

