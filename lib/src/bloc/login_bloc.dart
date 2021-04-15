import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:form_validation/src/bloc/validators.dart';



class LoginBloc with Validators {

  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Recuperar los datos del Stream 
  Stream<String> get emailStream     => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream  => _passwordController.stream.transform(validarPassword);


  Stream<bool>  get formValidStream => Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);
       
  // Insertar Valores al Stream 
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  // Obtener el ulitmo valor ingresado a los stream 
    String get email    => _emailController.value;
    String get password => _passwordController.value;


  //Cerrar los Streams 
  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }



}





