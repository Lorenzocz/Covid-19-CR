import 'package:flutter/material.dart';

class HomeAd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(
            centerTitle: true,
            backgroundColor: Colors.blue, title: Text('Administrador')),
      body: _opciones(context),
    );
  }

  Widget _opciones(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 160, bottom: 10, right: 10, left: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      color: Colors.blue.withOpacity(0.90),
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onPressed: () =>
                          Navigator.pushNamed(context, 'VistaNoticiaAdmin'),
                      child: SizedBox(
                        width: 110,
                        height: 110,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 50,
                              ),
                              Text(
                                "Crear Noticias",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                      color: Colors.blue.withOpacity(0.90),
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      onPressed: () =>
                          Navigator.pushNamed(context, 'VistaHorario'),
                      child: SizedBox(
                        width: 110,
                        height: 110,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 50,
                              ),
                              Text(
                                "Horarios de Atención",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
