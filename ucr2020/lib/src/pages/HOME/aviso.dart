import 'package:flutter/material.dart';

class Aviso extends StatelessWidget {
  const Aviso({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: _fondo(context)),
    );
  }

  Widget _fondo(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset('assets/sede.png'),
        color: Colors.white,
      ),
    );
  }
}
