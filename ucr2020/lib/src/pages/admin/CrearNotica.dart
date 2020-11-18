import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ucr2020/src/bloc/Providers.dart';
import 'package:ucr2020/src/models/News_models.dart';
import 'package:image_picker/image_picker.dart';

class NewsAdminPague extends StatefulWidget {
  /*
    Area de las variables a utilizar
  */

  @override
  _NewsAdminPagueState createState() => _NewsAdminPagueState();
}

class _NewsAdminPagueState extends State<NewsAdminPague> {
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

  NewModel newmodel = new NewModel();

  NoticasBloc noticiasBloc;
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    noticiasBloc = Provider.productosBloc(context);

    final NewModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      newmodel = prodData;
      setState(() {
        prodData.fechap = new DateFormat('yyyy-MM-dd - kk:mm').format(now);
      });
    }
    return Scaffold(
      key: scakey,
      appBar: AppBar(
        title: Text('Creación de noticias'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.image), onPressed: _seleccionarfoto),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: _tomarFoto)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(45.0),
          child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  _foto(prodData),
                  _titulo(),
                  // _departamento(),
                  // _fechas(),
                  _descripcion(),
                  _links(),
                  _contacto(),
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

  Widget _titulo() {
    return TextFormField(
        textCapitalization: TextCapitalization.sentences,
        maxLines: 3,
        minLines: 1,
        expands: false,
        maxLength: 120,
        decoration: InputDecoration(
            labelText: 'Titulo de la noticia : *',
            labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
            helperText: 'Introduce un buen titulo'),
        onSaved: (value) => newmodel.titulo = value,
        validator: (value) {
          if (value.length < 3) {
            return 'Introduce un buen titulo';
          } else {
            return null;
          }
        });
  }

  // Widget _departamento() {
  //   return TextFormField(
  //       textCapitalization: TextCapitalization.sentences,
  //       decoration: InputDecoration(
  //           labelText: 'Nombre del departamento : (opcional)',
  //           labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
  //           helperText: 'Ejemplo : TCU657'),
  //       onSaved: (value) => newmodel.depto = value,
  //       validator: (value) {});
  // }

  // Widget _fechas() {
  //   return TextFormField(
  //       textCapitalization: TextCapitalization.sentences,
  //       decoration: InputDecoration(
  //           labelText: 'Fechas importantes: *',
  //           labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
  //           helperText: 'Introduce una fecha para informar a la población'),
  //       onSaved: (value) => newmodel.fecha = value);
  // }

  Widget _contacto() {
    return TextFormField(
      expands: false,
      maxLength: 8,
      minLines: 1,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          labelText: 'Ingrese un contacto :',
          labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
          helperText: 'Ingrese un contacto ejemplo: 87785811 o 27755004'),
      onSaved: (value) => newmodel.contacto = value,
      validator: (value) {
        if (value.length < 8) {
          return 'Introduce un numero de 8 digitos';
        } else {
          return null;
        }
      },
    );
  }

  Widget _descripcion() {
    return TextFormField(
        textCapitalization: TextCapitalization.sentences,
        expands: false,
        maxLength: 600,
        minLines: 1,
        maxLines: 15,
        decoration: InputDecoration(
          labelText: 'Ingrese una descripción :',
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

  Widget _links() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      expands: false,
      maxLength: 100,
      minLines: 1,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Ingrese un link:',
        labelStyle: TextStyle(color: Colors.blue, fontSize: 18),
      ),
      onSaved: (value) => newmodel.url = value,
    );
  }

  /// TODO: BOTON de guardar

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

    if (foto != null) {
      newmodel.fotourl = await noticiasBloc.subirfoto(foto);
    }

    if (newmodel.id == null) {
      newmodel.like = 0;
      noticiasBloc.agregarnoticia(newmodel);
    } else {
      noticiasBloc.editar(newmodel);
    }
    mostrarSnackbar('Registro guardado');

    Navigator.pop(context);
    setState(() {
      DateTime now;
    });
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scakey.currentState.showSnackBar(snackbar);
  }

  Widget _foto(NewModel newmodel) {
    if (newmodel.fotourl != null) {
      return Image.network(
        newmodel.fotourl,
        fit: BoxFit.cover,
        height: 300.0,
        width: 400,
      );
    } else {
      if (foto != null) {
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }

      return Image.asset('assets/no-image.png');
    }
  }

  _seleccionarfoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      newmodel.fotourl = null;
    }

    setState(() {});
  }
}
