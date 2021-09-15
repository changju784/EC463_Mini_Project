import 'package:flutter/material.dart';

class Import_Recipe extends StatefulWidget {
  const Import_Recipe({Key? key}) : super(key: key);

  @override
  _Import_RecipeState createState() => _Import_RecipeState();
}

class _Import_RecipeState extends State<Import_Recipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Import Recipe'),
          backgroundColor: Colors.green[400],
          elevation: 0.0,

        )
    );
  }
}
