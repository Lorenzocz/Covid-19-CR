import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ucr2020/src/bloc/Providers.dart';
import 'package:ucr2020/src/bloc/horariobloc.dart';
import 'package:ucr2020/src/models/Horarios_model.dart';

class CrearHorarioA extends StatefulWidget {
  /*
    Area de las variables a utilizar
  */

  @override
  _CrearHorarioAPagueState createState() => _CrearHorarioAPagueState();
}

class _CrearHorarioAPagueState extends State<CrearHorarioA> {
//HomeAdminPage show= new HomeAdminPage();
  static DateTime now;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      now = DateTime.now();
    });
  }

  final formkey = GlobalKey<FormState>();

  final scakey = GlobalKey<ScaffoldState>();

  HorarioModel newmodel = new HorarioModel();

  HorariosBloc horariobloc;
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    horariobloc = Provider.horariobloc(context);

    final HorarioModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      newmodel = prodData;
    }
    return Scaffold(
      key: scakey,
      appBar: AppBar(
        title: Text('Creación de Horarios'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(45.0),
          child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  _nombreP(),
                  _departamento(),
                  _grupo(),
                  _descripcion(),
                  //  _links(),
                  //  _contacto(),
                  SizedBox(
                    height: 25.0,
                  ),
                  _boton(),
                ],
              )),
        ),
      ),
    );
  }

  ///   TEXT FLIELD
  ///
  ///

  Widget _nombreP() {
    return TextFormField(
        textCapitalization: TextCapitalization.sentences,
        maxLines: 2,
        minLines: 1,
        maxLength: 35,
        decoration: InputDecoration(
            labelText: 'Nombre del Profesor : *',
            labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
            helperText: 'Nombre del profesor'),
        onSaved: (value) => newmodel.nombreP = value,
        validator: (value) {
          if (value.length < 3) {
            return 'Introduce un buen titulo';
          } else {
            return null;
          }
        });
  }

  Widget _departamento() {
    return TextFormField(
        maxLines: 2,
        minLines: 1,
        maxLength: 35,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            labelText: 'Nombre del departamento o clase:',
            labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
            helperText: 'Ejemplo : Informatica'),
        onSaved: (value) => newmodel.depto = value,
        validator: (value) {});
  }

  Widget _grupo() {
    return TextFormField(
        maxLines: 2,
        minLines: 1,
        maxLength: 40,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            labelText: 'Curso*',
            labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
            helperText: 'Introduce el grupo que imparte el profesor'),
        onSaved: (value) => newmodel.grupo = value);
  }

  Widget _descripcion() {
    return TextFormField(
        textCapitalization: TextCapitalization.sentences,
        maxLines: 10,
        minLines: 1,
        maxLength: 170,
        decoration: InputDecoration(
          helperText: 'Ej: Aula 22, los miercoles a las 14:00 jueves etc..',
          labelText: 'Ingrese la fecha, aula y donde se imparten las clases :',
          labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
        ),
        onSaved: (value) => newmodel.descripcion = value,
        validator: (value) {
          if (value.length < 5) {
            return 'Ingrese una descripcion';
          } else {
            return null;
          }
        });
  }

  Widget _boton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.blue,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _validarform,
    );
  }

  void _validarform() async {
    if (!formkey.currentState.validate()) return null;

    formkey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (newmodel.id == null) {
      horariobloc.agregarnoticia(newmodel);
    } else {
      horariobloc.editar(newmodel);
    }
    mostrarSnackbar('Registro guardado');

    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scakey.currentState.showSnackBar(snackbar);
  }
}
