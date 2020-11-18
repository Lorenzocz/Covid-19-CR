import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:ucr2020/src/models/Horarios_model.dart';
import 'package:ucr2020/src/providers/horario_provider.dart';

class HorariosBloc {
  final _horiarioController = new BehaviorSubject<List<HorarioModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _horarioprovider = new HorarioProvider();
//  final _noticia = new NewModel();

  Stream<List<HorarioModel>> get noticiasStream => _horiarioController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarnoticiabloc() async {
    final _noti = await _horarioprovider.mostarnoticia();

    _horiarioController.sink.add(_noti);
  }


  void agregarnoticia(HorarioModel noticia)async{

    _cargandoController.sink.add(true);

    await _horarioprovider.cargarnoticia(noticia);
    _cargandoController.sink.add(false);
  }

Future<String> subirfoto(File foto)async{

    _cargandoController.sink.add(true);

    final fotourl =await _horarioprovider.subirimagen(foto);
    _cargandoController.sink.add(false);
    return fotourl;
  }

  void editar(HorarioModel noticia) async {
     _cargandoController.sink.add(true);
     _horarioprovider.editarProducto(noticia);
     _cargandoController.sink.add(false);

  }
  void editarlike(HorarioModel noticia) async {
     _cargandoController.sink.add(true);
     _horarioprovider.editarlike(noticia);
     _cargandoController.sink.add(false);

  }

void borrar(String id) async {
     _cargandoController.sink.add(true);
     _horarioprovider.borrarnoticia(id);
     _cargandoController.sink.add(false);

  }
  dipose() {
    _horiarioController?.close();
    _cargandoController?.close();
  }
}
