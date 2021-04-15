import 'package:flutter/material.dart';

import 'package:form_validation/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
       return Scaffold(         
           body: Stack(
             children: [
               _crearFondo(context),
               _loginForm(context),
             ],
           ),
          );
      }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado =  Container(
      height: size.height*0.4 ,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
              Color.fromRGBO(63, 63, 156, 1.0),
              Color.fromRGBO(90, 70, 178, 1.0)
          ])
      ),
    );
    
    final circulo = Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.08)

        ),
    );  

    return Stack(
      children: [
        fondoMorado,
        Positioned(top: 90.0,left: 30.0,child: circulo),
        Positioned(top: -40.0, right: -30.0,child: circulo),
        Positioned(bottom: -50.0, right: -10.0,child: circulo),
        Positioned(bottom: 120.0, right: 20.0,child: circulo),
        Positioned(bottom: -50.0, left: -20.0,child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Icon(Icons.person_pin_circle , size: 100.0, color: Colors.white,),
              SizedBox(height: 10.0, width: double.infinity,),
              Text('Luis Tejada' , style: TextStyle( color: Colors.white , fontSize: 25.0),)
            ],
          ),
        ),
      ],
    );
  }

  Widget _loginForm(BuildContext context){

    final bloc = Provider.of(context);
    final screenSize = MediaQuery.of(context).size;

    
    return SingleChildScrollView( 
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 220.0,
            )
          ),
          Container(
            width: screenSize.width*0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 4.0),
                  spreadRadius: 2.0
                )
              ]
            ),
            child: Column(
              children: [
                Text('Ingreso' , style: TextStyle( fontSize: 20.0 ),),
                SizedBox(height: 60.0,),
                // Input Para el Email
                InputEmail(bloc: bloc),
                SizedBox(height: 30.0,),
                // Input Para Contrasena
                InputPassword(bloc: bloc),
                SizedBox(height: 30.0,),
                // FormButton
                FormButton( ),
              ],
            ),
          ),
          
          Text('¿Olvido la contraseña?'),
          SizedBox(height: 100.0,)

        ],
      ),
    );
  }

}



class InputPassword extends StatelessWidget {
  const InputPassword({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final LoginBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0) ,
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                    icon: Icon(Icons.lock_outline_rounded , color: Colors.deepPurple,),
                    labelText: 'Password',
                    counterText: snapshot.data,
                    errorText: snapshot.error
              ),
              onChanged: bloc.changePassword,
            ),
          );
        },
    );
  }
}

class InputEmail extends StatelessWidget {

  const InputEmail({
    Key key,
    @required this.bloc,
  }) : super(key: key);

  final LoginBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0) ,
        child: TextField(
          keyboardType: TextInputType.emailAddress ,
          decoration: InputDecoration(
            icon: Icon(Icons.alternate_email , color: Colors.deepPurple,),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo Electronico',
            labelStyle: TextStyle(color: Colors.grey),
            hintStyle: TextStyle(color: Colors.grey),
            counterText: snapshot.data, 
            errorText: snapshot.error
          ),
          onChanged: bloc.changeEmail,
        ),
      );
      },
    );
  }
}

class FormButton extends StatelessWidget {
  
  
  const FormButton({
    Key key, 
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {


    final bloc = Provider.of(context);

      return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return ElevatedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80.0 , vertical: 15.0),
                child: Text('Ingresar'),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
                ),
                elevation: 0.0,
                primary: Colors.deepPurple
              ),
              onPressed: (snapshot.hasData)?()=>_login(bloc , context):null, 
          );
      
        },
      
      );
  }
  _login(LoginBloc bloc , BuildContext context){
      
      print('============================================== ');
      print('Email: ${ bloc.email }');
      print('Password: ${ bloc.password } ');
      print('============================================== ');

      Navigator.pushReplacementNamed(context, 'home');

    }
}