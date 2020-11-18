import 'dart:io';

import 'package:rxdart/rxdart.dart';

import 'package:ucr2020/src/models/News_models.dart';
import 'package:ucr2020/src/providers/NewAdmin_provider.dart';

class NoticasBloc {
  final _noticiaController = new BehaviorSubject<List<NewModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _noticiaprovider = new NewAdminProvider();
//  final _noticia = new NewModel();

  Stream<List<NewModel>> get noticiasStream => _noticiaController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarnoticiabloc() async {
    final _noti = await _noticiaprovider.mostarnoticia();

    _noticiaController.sink.add(_noti);
  }


  void agregarnoticia(NewModel noticia)async{

    _cargandoController.sink.add(true);

    await _noticiaprovider.cargarnoticia(noticia);
    _cargandoController.sink.add(false);
  }

Future<String> subirfoto(File foto)async{

    _cargandoController.sink.add(true);

    final fotourl =await _noticiaprovider.subirimagen(foto);
    _cargandoController.sink.add(false);
    return fotourl;
  }

  void editar(NewModel noticia) async {
     _cargandoController.sink.add(true);
     _noticiaprovider.editarProducto(noticia);
     _cargandoController.sink.add(false);

  }
  void editarlike(NewModel noticia) async {
     _cargandoController.sink.add(true);
     _noticiaprovider.editarlike(noticia);
     _cargandoController.sink.add(false);

  }

void borrar(String id) async {
     _cargandoController.sink.add(true);
     _noticiaprovider.borrarnoticia(id);
     _cargandoController.sink.add(false);

  }
  dipose() {
    _noticiaController?.close();
    _cargandoController?.close();
  }
}
