import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:permission_handler/permission_handler.dart';

const mapStyle = [];

class Homemap extends StatefulWidget {
  Homemap({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Homemap> {

  PermissionHandler _permisos= PermissionHandler();
  var _isvaliu=false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Set<Marker> _markers = Set();
  final double _zoom = 18.0000;
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(8.6444298, -83.1710062),zoom: 9.0000);
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _check();
  }

  _check()async{

    final permi= await _permisos.checkPermissionStatus(PermissionGroup.locationWhenInUse);
    if(permi==PermissionStatus.granted){
      

       setState(() {
        _isvaliu=true;
      });
    

      
    }else{
      setState(() {
        _isvaliu=false;
      });
    }
  }

  _request()async{
    final result=await _permisos.requestPermissions([PermissionGroup.locationWhenInUse]);
    //if(result.containskey(PermissionGroup.locationWhenInUse)){}
    if(result[PermissionGroup.locationWhenInUse]==PermissionStatus.granted){
      setState(() {
        _isvaliu=true;
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        key:_scaffoldKey ,
        
        
        appBar: AppBar(
          
          backgroundColor: Colors.blue,
           title: Text('<-- Toca para ver las rutas'),
           
          // centerTitle: true,
          actions: <Widget>[
            RaisedButton(
              child:  Icon(Icons.exit_to_app),
              onPressed: ()=>Navigator.pop(context))
           
          ],
          leading: new IconButton(icon: new Icon(Icons.map,size: 50.0,color: Colors.white,),
              onPressed: () => _scaffoldKey.currentState.openDrawer())
        ),
        
        drawer: _drawer(),
        body:_isvaliu?Stack(
          
          children: <Widget>[
            GoogleMap(
              
              markers: _markers,
              //minMaxZoomPreference: ,
              mapType: _defaultMapType,
              
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              minMaxZoomPreference: MinMaxZoomPreference.unbounded,
              
              onMapCreated: _onMapCreated,
              
              
              initialCameraPosition: _initialPosition,
            ),
            Container(
              margin: EdgeInsets.only(top: 80, right: 10),
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                      child: Icon(Icons.layers),
                      elevation: 5,
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        _changeMapType();
                      }),
                ],
              ),
            ),
          ],
        )
           :Center(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Text('Permiso para acceder a la Ubicación del dispositivo'),
                 SizedBox(
                   height: 20.0,
                 ),
                 CupertinoButton(child: Text('Aceptar'), onPressed: _request,
                 color: Colors.blue,)
                
               ],
             ),
           ),
          )

    );
  }

  Widget _drawer() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: Drawer(
        
        elevation: 10.0,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.blue,
                child: ListTile(
                  title: new Text(
                    "Places",
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                   trailing: new Icon(Icons.flight, color: Colors.white,size: 30.0,),
                ),
              ),

              //Divider(),
              Container(
                color: Colors.blue,
                child: ListTile(
                  title: new Text(
                    "Universid de Costa Rica",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: new Icon(
                    Icons.local_library,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  _goUCR();
                  Navigator.of(context).pop();
                },
                title: new Text("UCR GOLFITO"),
                trailing: new Icon(Icons.arrow_forward_ios),
              ),
              Container(
                color: Colors.blue,
                child: ListTile(
                  title: new Text(
                    "Bancos y Cajeros",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: new Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  _goToBCRU();
                  Navigator.of(context).pop();
                },
                title: new Text("Banco-Cajero BCR"),
                trailing: new Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  _cajerocivil();
                  Navigator.of(context).pop();
                },
                title: new Text("Cajero BCR-Pueblo Civil"),
                trailing: new Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  _goBN();
                  Navigator.of(context).pop();
                },
                title: new Text("Banco Nacional"),
                trailing: new Icon(Icons.arrow_forward_ios),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  _goBNcajero();
                  Navigator.of(context).pop();
                },
                title: new Text("Cajero BN-Pueblo Civil"),
                trailing: new Icon(Icons.arrow_forward_ios),
              ),
             
              Container(
                color: Colors.blue,
                child: ListTile(
                  title: new Text(
                    "Servicios y Supermercados",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: new Icon(
                    Icons.store_mall_directory,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  _goToDEPO();
                  Navigator.of(context).pop();
                },
                title: new Text("Depósito Libre Comercial de Golfito"),
                trailing: new Icon(Icons.arrow_forward_ios),
              ),
               Divider(),
              ListTile(
                onTap: () {
                  _tracopa();
                  Navigator.of(context).pop();
                },
                title: new Text("Servicio de Tracopa"),
                trailing: new Icon(Icons.arrow_forward_ios),
              ),
               Divider(),
              ListTile(
                onTap: () {
                  _farmacia();
                  Navigator.of(context).pop();
                },
                title: new Text("Farmacia Golfito"),
                trailing: new Icon(Icons.arrow_forward_ios),
              ),
               Divider(),

              

              ListTile(
                onTap: () {
                  _comercios();
                  Navigator.of(context).pop();
                },
                title: new Text("Comercios Costarricenses"),
                trailing: new Icon(Icons.arrow_forward_ios),
              ),
               Divider(),
              ListTile(
                onTap: () {
                  _pearson();
                  Navigator.of(context).pop();
                },
                title: new Text("Pearson"),
                trailing: new Icon(Icons.arrow_forward_ios),
              ),
               Divider(),
              ListTile(
                onTap: () {
                  _mega();
                  Navigator.of(context).pop();
                },
                title: new Text("Mega Super"),
                trailing: new Icon(Icons.arrow_forward_ios),
              ),
             
              Container(
                color: Colors.blue,
                child: ListTile(
                  title: new Text(
                    "Bar-Restaurantes",
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: new Icon(
                    Icons.local_bar,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  _goToPista();
                  Navigator.of(context).pop();
                },
                title: new Text("Restaurante-Bar la Pista"),
                trailing: new Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goUCR() async {
    double lat = 8.6448107;
    double long = -83.1717875;
    GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('UCR Golfito'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
                title: 'UCR GOLFITO', snippet: 'Welcome to UCR GOLFITO')),
      );
    });
  }

  Future<void> _goToPista() async {
    double lat = 8.6479549;
    double long = -83.1774804;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('Restaurante Bar la pista'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
                title: 'Restaurante Bar la pista',
                snippet: 'Welcome to Restaurante Bar la pista')),
      );
    });
  }

  Future<void> _goToDEPO() async {
    double lat = 8.6470958;
    double long = -83.1781777;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('Depósito Libre Comercial de Golfito'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
                title: 'Depósito Libre Comercial de Golfito',
                snippet: 'Welcome to Depósito Libre Comercial de Golfito')),
      );
    });
  }

  Future<void> _goToBCRU() async {
    double lat = 8.6480513;
    double long = -83.1787981;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('Cajeros BCR'),
            position: LatLng(lat, long),
            infoWindow:
                InfoWindow(title: 'Cajeros BCR', snippet: 'Cajeros BCR')),
      );
    });
  }

  Future<void> _cajerocivil() async {
    double lat = 8.6277517;
    double long = -83.1565097;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('Cajero BCR Pueblo Civil'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: 'Cajero BCR', snippet: 'Cajero BCR')),
      );
    });
  }

  Future<void> _goBN() async {
    double lat = 8.640323;
    double long = -83.1680587;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('Banco Nacional'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
                title: 'Banco Nacional', snippet: 'Welcome to Banco Nacional')),
      );
    });
  }

  Future<void> _goBNcajero() async {
    double lat = 8.625434;
    double long = -83.153729;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('Cajero BN-Pueblo civil'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
                title: 'Cajero BN', snippet: 'Welcome to Cajero BN')),
      );
    });
  }

  Future<void> _tracopa() async {
    double lat = 8.625771;
    double long = -83.154421;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('Servicio de Tracopa'),
            position: LatLng(lat, long),
            infoWindow:
                InfoWindow(title: 'Tracopa', snippet: 'Welcome to Tracopa')),
      );
    });
  }

  Future<void> _comercios() async {
    double lat = 8.626311;
    double long = -83.1554488;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('Comercios Costarricenses'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
                title: 'Comercios', snippet: 'Welcome to Comercios')),
      );
    });
  }

  Future<void> _pearson() async {
    double lat = 8.628272;
    double long = -83.156517;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('Pearson'),
            position: LatLng(lat, long),
            infoWindow:
                InfoWindow(title: 'Pearson', snippet: 'Welcome to Pearson')),
      );
    });
  }

  Future<void> _mega() async {
    double lat = 8.637703;
    double long = -83.165622;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('Mega Super'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
                title: 'Mega Super', snippet: 'Welcome to Mega Super')),
      );
    });
  }

  Future<void> _farmacia() async {
    double lat = 8.626879;
    double long = -83.155422;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('Farmacia Golfito'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
                title: 'Farmacia Golfito',
                snippet: 'Welcome to Farmacia Golfito')),
      );
    });
  }
}