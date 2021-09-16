import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/user.dart';
import 'package:untitled/screens/wrapper.dart';
import 'package:untitled/services/auth.dart';


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
    return StreamProvider<MyUser?>.value(
      catchError: (_,__) => null,
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Food Scanner',
        home: Wrapper(),
      ),
    );
  }
}
