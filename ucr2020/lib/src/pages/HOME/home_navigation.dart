import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:ucr2020/src/pages/Contactos/Contactos.dart';
import 'package:ucr2020/src/pages/HOME/aviso.dart';
import 'package:ucr2020/src/pages/Horarios/horario_home.dart';
import 'package:ucr2020/src/pages/vistausuario/vista_usuario_noticia.dart';

class HomeNavigation extends StatefulWidget {
  HomeNavigation({Key key}) : super(key: key);

  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int _pages = 1;
  final _pageOption = [
    ContactsPage(),
    VistaNoticia(),
    HomeHorario(),
    Aviso()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOption[_pages],
      bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.bounceIn,
          backgroundColor: Colors.white,
          animationDuration: Duration(milliseconds: 200),
          color: Colors.blue,
          onTap: (index) {
            setState(() {
              _pages = index;
            });
          },
          index: 1,
          items: <Widget>[
            Icon(Icons.call, color: Colors.white),
            Icon(Icons.accessibility_new, color: Colors.white),
            Icon(Icons.apps, color: Colors.white),
            Icon(Icons.info, color: Colors.white),
          ]),
    );
  }
}
