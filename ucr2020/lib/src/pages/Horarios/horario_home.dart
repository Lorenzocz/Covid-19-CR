import 'package:flutter/material.dart';

class HomeHorario extends StatelessWidget {



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          backgroundColor: Colors.blue, title: Text('Accesos Importantes')),
      body: _opciones(context),
    );
  }

 Widget _opciones(BuildContext context) {
    final _size=MediaQuery.of(context).size;

    return  SingleChildScrollView(
          child: Container(
   
              padding: EdgeInsets.only(
                top: _size.height*0.10,
                bottom: 10,
               // right: 8,
                left: 10
              ),
             alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                           padding: EdgeInsets.all(10),
                            child: RaisedButton(
                              color: Colors.blue.withOpacity(0.90),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              onPressed: ()=>Navigator.pushNamed(context, 'VistaHorarioU'),
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                       Icon(Icons.content_paste, color: Colors.white,size: 50,),
                                      Text("Horarios de Atención",
                                          textAlign: TextAlign.center, style: TextStyle(fontSize: 18,color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: RaisedButton(
                              color: Colors.blue.withOpacity(0.90),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              onPressed: ()=>Navigator.pushNamed(context, 'Homemap'),
                              child: SizedBox(
                                  width: 100,
                                height: 100,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                       Icon(Icons.location_on, color: Colors.white,size: 50,),
                                      Text("Mapa de Golfito",
                                          textAlign: TextAlign.center, style: TextStyle(fontSize: 18,color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      
                    ],
                    
                  ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: RaisedButton(
                              color: Colors.blue.withOpacity(0.90),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              onPressed: ()=>Navigator.pushNamed(context, 'Urls'),
                              child: SizedBox(
                                  width: 100,
                                height: 100,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                       Icon(Icons.link, color: Colors.white,size: 50,),
                                      Text("Accesos Importantes",
                                          textAlign: TextAlign.center, style: TextStyle(fontSize: 18,color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: RaisedButton(
                              color: Colors.blue.withOpacity(0.90),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              onPressed: ()=>Navigator.pushNamed(context, 'login'),
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                       Icon(Icons.account_circle, color: Colors.white,size: 50,),
                                      Text("Acceso Admin",
                                          textAlign: TextAlign.center, style: TextStyle(fontSize: 18,color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      
                    ],
                    
                  ),
                  
  
                ],
              ),
            ),
    );
      


 }
}
