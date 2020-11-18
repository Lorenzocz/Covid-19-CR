import 'package:flutter/material.dart';
import 'package:ucr2020/src/pages/HOME/aviso.dart';

import 'package:ucr2020/src/pages/HOME/home_navigation.dart';
import 'package:ucr2020/src/pages/Horarios/horario_atencion/vistaUHorario.dart';
import 'package:ucr2020/src/pages/Horarios/horario_home.dart';
import 'package:ucr2020/src/pages/admin/CrearNotica.dart';
import 'package:ucr2020/src/pages/admin/HomeAd.dart';
// import 'package:ucr2020/src/pages/admin/HomeAdmin_Page.dart';
// import 'package:ucr2020/src/pages/admin/MostrarInfo.dart';

// import 'package:ucr2020/src/pages/admin/editarnoticia.dart';
import 'package:ucr2020/src/pages/admin/horariosA/crearhorario.dart';
import 'package:ucr2020/src/pages/admin/horariosA/vista_horarios.dart';
// import 'package:ucr2020/src/pages/admin/imagen.dart';
import 'package:ucr2020/src/pages/admin/vista_notica_admin.dart';
import 'package:ucr2020/src/pages/login/login_page.dart';
import 'package:ucr2020/src/pages/map/mapa.dart';
import 'package:ucr2020/src/pages/urls/urls.dart';
import 'package:ucr2020/src/pages/vistausuario/Informacion-usuario.dart';
import 'package:ucr2020/src/pages/vistausuario/Mostarimagen_vistausuario.dart';
import 'package:ucr2020/src/pages/vistausuario/vista_usuario_noticia.dart';

//import 'package:ucr2020/src/pages/vistausuario/vista.dart';

import 'bloc/Providers.dart';

class UCR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sede del Sur',
        initialRoute: 'HomeNavigation',
        routes: {
          'HomeNavigation': (BuildContext context) => HomeNavigation(),

          'login': (BuildContext context) => LoginPage(),
          'VistaNoticiaAdmin': (BuildContext context) => VistaNoticiaAdmin(),
          // 'AdminHomepage': (BuildContext context) => HomeAdminPage(),
          // pantalla que muestra botones crear homead
          'HomeAd': (BuildContext context) => HomeAd(),
          'NewsAdminpage': (BuildContext context) => NewsAdminPague(),
          // 'MostarNoticia': (BuildContext context) => MostarNoticia(),
          // 'EditarNoticia': (_) => EditarNoticia(),
          'Imagen': (BuildContext context) => Imagen(),
          'Homemap': (BuildContext context) => Homemap(),
          'avisos': (BuildContext context) => Aviso(),
          'MostarInformacion': (BuildContext context) => MostarInformacionUsuario(),


        //horario
         'HomeHorario': (BuildContext context) => HomeHorario(),
         'Urls': (BuildContext context) => Urls(),
          'VistaHorarioU': (BuildContext context) => VistaHorarioU(),
           'VistaHorario': (BuildContext context) => VistaHorario(),
           'CrearHorarioA': (BuildContext context) => CrearHorarioA(),            // vista creada 21/ marzo/ vista_usuario_noticia
            'vistaUsuarioNoticia': (BuildContext context ) => VistaNoticia(),


        },
      ),
    );
  }
}
