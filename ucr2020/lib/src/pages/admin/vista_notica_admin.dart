import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ucr2020/src/bloc/Providers.dart';
import 'package:ucr2020/src/models/News_models.dart';

class VistaNoticiaAdmin extends StatefulWidget {
  @override
  _HomeAdminPageState createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<VistaNoticiaAdmin> {
  NewModel data = new NewModel();
  bool imagencargada = false;
  bool _elimiar = false;

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    _elimiar = false;
  }

  dynamic _sizew;
  dynamic _sizeh;
  @override
  Widget build(BuildContext context) {
    _sizew = MediaQuery.of(context).size.width;
    _sizeh = MediaQuery.of(context).size.height;
    final noticiabloc = Provider.productosBloc(context);
    noticiabloc.cargarnoticiabloc();

    return Scaffold(
      appBar: AppBar(
        title: Text('Vista de Noticias Admin'),
        
      ),
      body: _news(noticiabloc),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () =>
              Navigator.pushNamed(context, 'NewsAdminpage', arguments: data)),
    );
  }

  Widget refresh() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 60.0,
      ),
    );
  }

  Widget _news(NoticasBloc noticia) {
    return StreamBuilder(
      stream: noticia.noticiasStream,
      builder: (BuildContext context, AsyncSnapshot<List<NewModel>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return ListView.builder(
            key: UniqueKey(),
            itemCount: (data.length > 0) ? data.length : 0,
            itemBuilder: (context, index) {
              return Dismissible(
                background: refresh(),
                onDismissed: (direccion) => _showAlertDialog(noticia, data[index]),
                key: UniqueKey(),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, 'MostarInformacion',
                        arguments: data[index]),
                    child: Card(
                      elevation: 2,
                      color: Colors.white,
                      semanticContainer: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        height: (_sizeh > 650) ? 270 : _sizeh - 295,
                        width: double.infinity,
                        color: Colors.white,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 5,
                              left: 5,
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 200,
                                    width: _sizew - 40,
                                    child: _imagen(data[index].fotourl),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 5, child: _texto(data[index].titulo)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _imagen(data) {
    if (data == null) {
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        fadeInDuration: Duration(milliseconds: 100),
        image:AssetImage('assets/sede.png'),
        fit: BoxFit.cover,
      );
      //Image(image: AssetImage('assets/no-image.png'));
    } else {
      return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        fadeInDuration: Duration(milliseconds: 100),
        image: NetworkImage(data),
        fit: BoxFit.cover,
      );
    }
  }

  Widget _texto(String data) {
    if (data == null) {
      return Container();
    } else {
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: (_sizeh > 650) ? 50 : _sizeh - 510,
          width: (_sizeh > 650) ? 360 : _sizew - 50,
          color: Colors.transparent,
          child: Center(
            child: RichText(
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: data,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                  ],
                )),
          ));
    }
  }

  _showAlertDialog(NoticasBloc bloc, NewModel data) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("Alerta"),
            content: Text("¿Deseás eliminar la noticia?"),
            actions: <Widget>[
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_elimiar == false) {
                    setState(() {
                      Navigator.pop(context);
                    });
                  }
                },
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Aceptar",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _elimiar = true;
                  });

                  if (_elimiar == true) {
                    setState(() {
                      bloc.borrar(data.id);
                    });
                  }

                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
