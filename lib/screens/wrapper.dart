import 'package:provider/provider.dart';
import 'package:untitled/models/main.dart';
import 'package:untitled/models/user.dart';
import 'package:untitled/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/authenticate/authenticate.dart';
import 'package:untitled/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user);
    // return either Home or Auth widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home(title: 'Food Scanner');
    }
  }
}
