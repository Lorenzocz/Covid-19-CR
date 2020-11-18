import 'package:flutter/material.dart';
import 'package:ucr2020/src/bloc/horariobloc.dart';
import 'package:ucr2020/src/bloc/login_bloc.dart';

import 'noticias_bloc.dart';
export 'noticias_bloc.dart';
class Provider extends InheritedWidget {

  final loginBloc      = new LoginBloc();
  final _noticiabloc = new  NoticasBloc();
  final _horariobloc=new HorariosBloc();


  static Provider _instancia;

  factory Provider({ Key key, Widget child }) {

    if ( _instancia == null ) {
      _instancia = new Provider._internal(key: key, child: child );
    }

    return _instancia;

  }

  Provider._internal({ Key key, Widget child })
    : super(key: key, child: child );


  

  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child );

 
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider ).loginBloc;
  }

  static NoticasBloc productosBloc ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider )._noticiabloc;
    }

     static HorariosBloc horariobloc ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider )._horariobloc;
  }
   
}