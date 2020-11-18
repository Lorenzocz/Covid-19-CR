import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:ucr2020/src/bloc/Providers.dart';
import 'package:ucr2020/src/bloc/login_bloc.dart';
const String testDevice = 'MobileId';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}




class _LoginPageState extends State<LoginPage> {




   static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );
    BannerAd _bannerAd;
  

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId:"ca-app-pub-4028885124199049/7629178359",
        //"ca-app-pub-4028885124199049/7629178359",
      //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

   @override
  void initState() {
   //"ca-app-pub-4028885124199049~1937512750"
     FirebaseAdMob.instance.initialize(appId:"ca-app-pub-4028885124199049~1937512750");
    //Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show();
       super.initState();
  }

   void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }
  













  final formkey = GlobalKey<FormState>();

  final scakey = GlobalKey<ScaffoldState>();

  final String _contra = 'Asociacion2020';

  String _contran='';

  final String _usuario = 'Asociacion';

  String _usuarion='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scakey,
        body: Stack(
          children: <Widget>[
            _crearFondo(context),
            _loginForm(context),
          ],
        ));
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 60.0),
                  _crearEmail(bloc),
                  SizedBox(height: 30.0),
                  _crearPassword(bloc),
                  SizedBox(height: 30.0),
                  _crearBoton(context)
                ],
              ),
            ),
          ),
          //Text('¿Olvido la contraseña?'),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    // return StreamBuilder(
    //   stream: bloc.emailStream,
    //   builder: (BuildContext context, AsyncSnapshot snapshot){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.blue),
          hintText: 'ejemplo@correo.com',
          labelText: 'Correo electrónico',
          // counterText: snapshot.data,
          // errorText: snapshot.error
        ),
        validator: (value) {
          if (value.length < 5) {
            return 'Ingrese una descripcion';
          } else {
            return null;
          }
        },
        onSaved: (value) => _usuarion = value,
        // onChanged: bloc.changeEmail,
      ),
    );

    //   },
    // );
  }

  Widget _crearPassword(LoginBloc bloc) {
    // return StreamBuilder(
    //   stream: bloc.passwordStream,
    //   builder: (BuildContext context, AsyncSnapshot snapshot){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        onSaved: (value) => _contran = value,
        validator: (value) {
          if (value.length < 5) {
            return 'Ingrese una descripcion';
          } else {
            return null;
          }
        },
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.blue),
          labelText: 'Contraseña',
          // counterText: snapshot.data,
          // errorText: snapshot.error
        ),
        onChanged: bloc.changePassword,
      ),
    );

    //   },
    // );
  }

  Widget _crearBoton(BuildContext context) {
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    // return StreamBuilder(
    //   stream: bloc.emailStream,
    //   builder: (BuildContext context, AsyncSnapshot snapshot){

    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Ingresar'),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: () => _validarform(context),
      // snapshot.hasData ? ()=> _login(bloc, context) : null
    );
    //   },
    // );
  }

  _login(BuildContext context) {
    // print('================');
    // print('Email: ${ bloc.email }');
    // print('Password: ${ bloc.password }');
    // print('================');

    if (_usuario == 'Asociacion' && _contra == 'Asociacion2020') {
      Navigator.pushReplacementNamed(context, 'HomeAd');
    }
    return [];
  }

  void _validarform(BuildContext context) async {
    if (!formkey.currentState.validate()) return null;

    formkey.currentState.save();
    if(_usuario==_usuarion){
      if(_contra==_contran){
Navigator.pushReplacementNamed(context, 'HomeAd');
      }
 
    }
   
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
     // height: size.height * 0.4,
      width: double.infinity,
      child: Image(image:AssetImage('assets/ee.jpeg')),
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(colors: <Color>[
      //   Colors.blue,
      //   Color.fromRGBO(90, 70, 178, 1.0)
      // ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(bottom: 10.0, left: 10.0, child: Text('Foto: @wiliam fallas',
                  style: TextStyle(color: Colors.blue, fontSize: 15.0,fontStyle: FontStyle.italic))),
        
        // Positioned(top: 90.0, left: 30.0, child: circulo),
        // Positioned(top: -40.0, right: -30.0, child: circulo),
        // Positioned(bottom: -50.0, right: -10.0, child: circulo),
        // Positioned(bottom: 120.0, right: 20.0, child: circulo),
        // Positioned(bottom: -50.0, left: -20.0, child: circulo),
        
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              //Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              // Text('Fernando Herrera',
              //     style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }
}
