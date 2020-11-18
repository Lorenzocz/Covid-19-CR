import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ucr2020/src/bloc/Providers.dart';
import 'package:ucr2020/src/models/News_models.dart';
import 'package:ucr2020/src/providers/NewAdmin_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_admob/firebase_admob.dart';

class MostarInformacionUsuario extends StatefulWidget {
  @override
  _MostarInformacionUState createState() => _MostarInformacionUState();
}

class _MostarInformacionUState extends State<MostarInformacionUsuario> {
  //admod

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: "ca-app-pub-4028885124199049/7629178359",
        //"ca-app-pub-4028885124199049/7629178359",
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        //targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  @override
  void initState() {
    //"ca-app-pub-4028885124199049~1937512750"
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-4028885124199049~1937512750");

    ///Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  dynamic _sizew;
  double _sizeh;
  Widget build(BuildContext context) {
    _sizew = MediaQuery.of(context).size.width;
    _sizeh = MediaQuery.of(context).size.height;
    final noticiabloc = Provider.productosBloc(context);
    noticiabloc.cargarnoticiabloc();
    final NewModel noticia = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Información'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(children: [
          _fondo(),
          Positioned(child: _fondoB()),
          Positioned(
              top: _sizepositiontitulo(_sizeh),
              //(_sizeh > 650) ? _sizeh - 680 : _sizeh - 570,
              left: (_sizeh > 650) ? 30 : 25,
              child: _titulo(noticia)),
          Positioned(
              top: _sizepositioninfo(_sizeh),
              //(_sizeh > 650) ? _sizeh - 600 : _sizeh - 475,
              left: (_sizeh > 650) ? 30 : 25,
              child: _informacion(noticia)),
          Positioned(
              bottom: _sizepositionlink(_sizeh),
              //(_sizeh > 650) ? _sizeh - 580 : _sizeh - 460,
              left: 30,
              child: _links(noticia)),
          Positioned(
              bottom: _sizepositiontele(_sizeh),
              //(_sizeh > 650) ? _sizeh - 630 : _sizeh - 510,
              left: 30,
              child: _telefono(noticia)),
          Positioned(
              bottom: _sizepositionimage(_sizeh),
              left: 30,
              child: _imagen(noticia)),
          Positioned(
              bottom: _posicionfecha(_sizeh),
              left: 30,
              child: _fechaub(noticia))
        ]),
      ),
    );
  }

  Widget _fondo() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue.withOpacity(0.8),
        ),
        height: (_sizeh > 650) ? _sizeh - 200 : _sizeh - 100,
        width: (_sizeh > 650) ? _sizew - 20 : _sizew - 20,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
                image: AssetImage('assets/madera.png'), fit: BoxFit.cover)),
      ),
    );
  }

  Widget _fondoB() {
    return Center(
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          height: (_sizeh > 650) ? _sizeh - 300 : _sizeh - 150,
          width: _sizew - 50,
        ),
      ),
    );
  }

  Widget _titulo(NewModel noticia) {
    if (noticia.titulo != null && noticia.titulo != '') {
      return Center(
        child: Container(
            height: _titusi(_sizeh),
            //(_sizeh > 650) ? _sizeh - 700 : _sizeh - 510,
            width: (_sizeh > 650) ? _sizew - 60 : _sizew - 50,
            color: Colors.white,
            child: Text('${noticia.titulo.trim()}',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)),
      );
    } else {
      return Container();
    }
  }

  Widget _informacion(NewModel noticia) {
    if (noticia.descripcion != null && noticia.titulo != '') {
      return Center(
        child: Container(
            height: _tama(noticia.descripcion.length),
            width: (_sizeh > 640) ? _sizew - 60 : _sizew - 50,
            color: Colors.white,
            child: Card(
              elevation: 0.2,
              child: SingleChildScrollView(
                child: Scrollbar(
                  child: Text('${noticia.descripcion}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start),
                ),
              ),
            )),
      );
    } else {
      return Container();
    }
  }

  double _tama(int tama) {
    double tamanio = 650;

    if (_sizeh > 640) {
      if (tama > 30) {
        tamanio = _sizeh - 580;
      } else {
        tamanio = _sizeh - 650;
      }
    } else {
      tamanio = _sizeh - 390;
    }

    return tamanio;
  }

  Widget _links(NewModel noticia) {
    if (noticia.url != null && noticia.url != '') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () => launch(noticia.url),
            child: Card(
              elevation: 5,
              child: IconButton(
                  icon: Icon(
                    Icons.link,
                    color: Colors.blue,
                    size: 30,
                  ),
                  onPressed: null),
            ),
          ),
          Container(
            height: 30,
            //(_sizeh > 650) ? _sizeh - 750 : _sizeh - 550,
            width: _sizew - 200,
            color: Colors.transparent,
            child: Center(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: RichText(
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        text: '${noticia.url}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline))

                    //,
                    ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _telefono(NewModel noticia) {
    if (noticia.contacto != null && noticia.contacto != '') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () => _launchURL(noticia.contacto),
            child: Card(

              color: Colors.white,
              elevation: 5,
              child: IconButton(
                  icon: Icon(
                    Icons.phone,
                    color: Colors.blue,
                    size: 30,
                  ),
                  onPressed: null),
            ),
          ),
          Container(
            height: 30,
            width: _sizew - 111,
            color: Colors.transparent,
            child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                    text: '   506+  ${noticia.contacto}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ))),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  static void _launchURL(String contact) async {
    String u = contact;

    if (await canLaunch('tel:' + u)) {
      await launch('tel:' + u);
    } else {
      throw 'Could not launch $u';
    }
  }

  double _sizepositiontitulo(double size) {
    double tama;
    if (size > 640 && size > 740) {
      tama = size - 680;
    } else if (size > 640 && size < 740) {
      tama = size - 600;
    } else {
      tama = size - 570;
    }

    return tama;
  }

  double _sizepositioninfo(double size) {
    double tama;
    if (size > 640 && size > 740) {
      tama = size - 600;
    } else if (size > 640 && size < 740) {
      tama = size - 520;
    } else {
      tama = size - 480;
    }

    return tama;
  }

  double _sizepositionlink(double size) {
    double tama;
    if (size > 640 && size > 740) {
      tama = size - 630;
    } else if (size > 640 && size < 740) {
      tama = size - 570;
    } else {
      tama = size - 520;
    }

    return tama;
  }

  double _sizepositiontele(double size) {
    double tama;
    if (size > 640 && size > 740) {
      tama = size - 680;
    } else if (size > 640 && size < 740) {
      tama = size - 620;
    } else {
      tama = size - 570;
    }

    return tama;
  }

  double _titusi(double size) {
    double tama;
    if (size > 640 && size > 740) {
      tama = size - 700;
    } else if (size > 640 && size < 740) {
      tama = size - 500;
    } else {
      tama = size - 510;
    }

    return tama;
  }

//Size(360.0, 640.0)
//wi: 360 , h: 604
  Widget _imagen(NewModel noticia) {
    if (noticia.fotourl != null && noticia.fotourl != '') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, 'Imagen', arguments: noticia),
            child: Card(
              color: Colors.white,
              elevation: 2,
              child: IconButton(
                  icon: Icon(
                    Icons.image,
                    color: Colors.blue,
                    size: 30,
                  ),
                  onPressed: null),
            ),
          ),
          Container(
            height: 30,
            width: _sizew - 111,
            color: Colors.transparent,
            child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                    text: '   Mostrar Imagen',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ))),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  double _sizepositionimage(double size) {
    double tama;
    if (size > 640 && size > 740) {
      tama = size - 579;
    } else if (size > 640 && size < 740) {
      tama = size - 520;
    } else {
      tama = size - 470;
    }

    return tama;
  }

  /// fecha de pulicación
  ///
  Widget _fechaub(NewModel noticia) {
    if (noticia.fechap != null && noticia.fechap != '') {
      return Center(
        child: Container(
            height: 30,
            //(_sizeh > 650) ? _sizeh - 700 : _sizeh - 510,
            width: (_sizeh > 650) ? _sizew - 60 : _sizew - 50,
            color: Colors.transparent,
            child: Text('Fecha de publicación : ${noticia.fechap.trim()}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)),
      );
    } else {
      return Container();
    }
  }

  double _posicionfecha(double size) {
    double tama;
    if (size > 640 && size > 740) {
      tama = size - 740;
    } else if (size > 640 && size < 740) {
      tama = size - 670;
    } else {
      tama = size - 605;
    }

    return tama;
  }

 
}
