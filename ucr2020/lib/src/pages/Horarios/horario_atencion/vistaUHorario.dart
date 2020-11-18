import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ucr2020/src/bloc/Providers.dart';
import 'package:ucr2020/src/bloc/horariobloc.dart';
import 'package:ucr2020/src/models/Horarios_model.dart';

const String testDevice = 'MobileId';

class VistaHorarioU extends StatefulWidget {
  @override
  _VistaHorarioUPageState createState() => _VistaHorarioUPageState();
}

class _VistaHorarioUPageState extends State<VistaHorarioU> {
  ///bloc ads

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );
  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: "ca-app-pub-4028885124199049/5638661029",
        //"ca-app-pub-4028885124199049/7629178359",
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  @override
  void initState() {
    //"ca-app-pub-4028885124199049~1937512750"
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-4028885124199049~1937512750");
    // //Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  //
  HorarioModel data = new HorarioModel();
  bool imagencargada = false;
  dynamic _sizew;
  double _sizeh;
  @override
  Widget build(BuildContext context) {
    _sizew = MediaQuery.of(context).size.width;
    _sizeh = MediaQuery.of(context).size.height;
    final horariobloc = Provider.horariobloc(context);

    horariobloc.cargarnoticiabloc();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Horarios de Atención'),
      ),
      body: _news(horariobloc),
    );
  }

  Widget _news(HorariosBloc noticia) {
    return StreamBuilder(
      stream: noticia.noticiasStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<HorarioModel>> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              return _vista1(context, data[i], noticia);
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

  Widget _vista1(BuildContext context, HorarioModel data, HorariosBloc bloc) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 10),
      child: Stack(
        children: <Widget>[
          _fondopizzarra(context, data),
          Positioned(
              left: 31,
              top: _nombrepposition(_sizeh),
              child: _nombreProfe(data)),
          Positioned(
              top: _sizepositiontitulo(_sizeh),
              left: 31,
              child: _asignatura(data)),
          Positioned(top: _cursopo(_sizeh), left: 31, child: _curso(data)),
          Positioned(top: _titusi(_sizeh), left: 31, child: _descrip(data)),
        ],
      ),
    );
  }

  Widget _fondopizzarra(BuildContext context, HorarioModel data) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.transparent,
        ),
        height: _tamafondoaltura(_sizeh),
        //(_sizeh > 650) ? _sizeh - 515 : _sizeh - 200,
        width: _tamafondo(_sizeh),
        //(_sizeh > 650) ? _sizew - 25 : _sizew - 20,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
                image: AssetImage('assets/pizarra.png'), fit: BoxFit.cover)),
      ),
    );
  }

  Widget _nombreProfe(HorarioModel horario) {
    if (horario.nombreP != null && horario.nombreP != '') {
      return Container(
        child: Center(
          child: Container(
              height: (_sizeh > 650) ? 100 : 50,
              //
              width: (_sizeh > 650) ? _sizeh - 450 : _sizeh - 300,
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.assignment_ind,
                    size: 40,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('${horario.nombreP}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ],
              )),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _asignatura(HorarioModel horario) {
    if (horario.depto != null && horario.depto != '') {
      return Container(
        child: Center(
          child: Container(
              height: (_sizeh > 650) ? 100 : 50,
              //(_sizeh > 650) ? _sizeh - 700 : _sizeh - 510,
              width: (_sizeh > 650) ? _sizeh - 450 : _sizeh - 300,
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.assignment,
                    size: 40,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('${horario.depto}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ],
              )),
        ),
      );
    } else {
      return Container();
    }
  }

  double _sizepositiontitulo(double size) {
    double tama;
    if (size > 640 && size > 740) {
      tama = size - 760;
    } else if (size > 640 && size < 740) {
      tama = size - 700;
    } else {
      tama = size - 555;
    }

    return tama;
  }

  Widget _curso(HorarioModel horario) {
    if (horario.depto != null && horario.depto != '') {
      return Container(
        child: Center(
          child: Container(
              height: (_sizeh > 650) ? 100 : 50,
              //(_sizeh > 650) ? _sizeh - 700 : _sizeh - 510,
              width: (_sizeh > 650) ? _sizeh - 450 : _sizeh - 300,
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.assignment_turned_in,
                    size: 40,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('${horario.grupo}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ],
              )),
        ),
      );
    } else {
      return Container();
    }
  }

  double _cursopo(double size) {
    double tama;
    if (size > 640 && size > 740) {
      tama = size - 720;
    } else if (size > 640 && size < 740) {
      tama = size - 660;
    } else {
      tama = size - 520;
    }

    return tama;
  }

  Widget _descrip(HorarioModel noticia) {
    if (noticia.descripcion != null && noticia.descripcion != '') {
      return Center(
        child: Container(
            height: 100,
            //(_sizeh > 650) ? _sizeh - 700 : _sizeh - 510,
            width: (_sizeh > 650) ? _sizew - 60 : _sizew - 50,
            color: Colors.transparent,
            child: Text(' ${noticia.descripcion}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left)),
      );
    } else {
      return Container();
    }
  }

  double _titusi(double size) {
    double tama;
    if (size > 640 && size > 740) {
      tama = size - 640;
    } else if (size > 640 && size < 740) {
      tama = size - 580;
    } else {
      tama = size - 470;
    }

    return tama;
  }

  double _tamafondo(double size) {
    double tama;
    if (size > 640 && size > 740) {
      tama = _sizew - 25;
    } else if (size > 640 && size < 740) {
      tama = size - 380;
    } else {
      tama = size - 280;
    }

    return tama;
  }

  double _tamafondoaltura(double size) {
    double tama;
    if (size > 640 && size > 740) {
      tama = size - 515;
    } else if (size > 640 && size < 740) {
      tama = size - 450;
    } else {
      tama = size - 340;
    }

    return tama;
  }

  double _nombrepposition(double size) {
    double tama;
    if (size > 640 && size > 740) {
      tama = size - 800;
    } else if (size > 640 && size < 740) {
      tama = size - 745;
    } else {
      tama = size - 590;
    }

    return tama;
  }
}
