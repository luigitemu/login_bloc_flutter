import 'package:flutter/material.dart';
import 'package:form_validation/src/bloc/provider.dart';


class HomePage extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     final bloc = Provider.of(context);
       return Scaffold(
         appBar: AppBar(
           title: Text('Home Page'),
         ),
           body: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Text('Email: ${ bloc.email  } '),
                 Divider(),
                 Text('Password: ${ bloc.password  } '),
               ],
             ),
           )
          );
      }
}