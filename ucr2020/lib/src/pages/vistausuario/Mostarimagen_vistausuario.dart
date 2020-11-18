import 'package:flutter/material.dart';
import 'package:ucr2020/src/models/News_models.dart';

class Imagen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NewModel pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.black,
      persistentFooterButtons: <Widget>[
        Text(
          'Desing from @LorenzoCarazoZuñiga',
          style: TextStyle(
              fontSize: 6, color: Colors.blue, fontStyle: FontStyle.italic),
        ),
      ],
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(child: _imagen(context, pelicula)),
    );
  }

  Widget _imagen(BuildContext context, NewModel pelicula) {
    return Center(
      child: Image(
        image: NetworkImage(pelicula.fotourl),
        fit: BoxFit.cover,
      ),
    );
  }
}