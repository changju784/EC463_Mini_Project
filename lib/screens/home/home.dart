import 'package:flutter/material.dart';
import 'package:untitled/screens/home/import_recipe.dart';
import 'package:untitled/screens/home/update_recipe.dart';
import 'package:untitled/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text('Food Scanner'),
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(onPressed: () async{await _auth.signOut();}, icon: Icon(Icons.person), label: Text('logout'),)
        ]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
                color: Colors.green[400],
                child: Text('Update Recipe', style: TextStyle(color: Colors.white),),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Update_Recipe()),
                  );
                }
            ),
            RaisedButton(
                color: Colors.green[400],
                child: Text('Import Recipe', style: TextStyle(color: Colors.white),),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Import_Recipe()),
                  );
                }
            ),
          ]
        )
      )
    );
  }
}
