import 'package:flutter/material.dart';

class Update_Recipe extends StatefulWidget {
  const Update_Recipe({Key? key}) : super(key: key);

  @override
  _Update_RecipeState createState() => _Update_RecipeState();
}

class _Update_RecipeState extends State<Update_Recipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Recipe'),
        backgroundColor: Colors.green[400],
        elevation: 0.0,

      )
    );
  }
}
