import 'package:flutter/material.dart';

import 'package:form_validation/src/pages/home_page.dart';
import 'package:form_validation/src/pages/login_page.dart';
 
import 'package:form_validation/src/bloc/provider.dart';
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Provider(
      child: MaterialApp(
      title: 'Login ',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
         'login'  : (_) => LoginPage(),
         'home'   : (_) => HomePage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),  
    ),

    );
    
    
  }
}