import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
const String testDevice = 'MobileId';
class Urls extends StatefulWidget {
  @override
  _UrlsState createState() => _UrlsState();
}

class _UrlsState extends State<Urls> {

 ///
  
  //  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   testDevices: testDevice != null ? <String>[testDevice] : null,
  //   nonPersonalizedAds: true,
  //   keywords: <String>['Game', 'Mario'],
  // );
  //   BannerAd _bannerAd;
  

  // BannerAd createBannerAd() {
  //   return BannerAd(
  //       adUnitId:"ca-app-pub-4028885124199049/7618629556",
  //       //"ca-app-pub-4028885124199049/7629178359",
  //     //Change BannerAd adUnitId with Admob ID
  //       size: AdSize.banner,
  //       targetingInfo: targetingInfo,
  //       listener: (MobileAdEvent event) {
  //         print("BannerAd $event");
  //       });
  // }

   @override
  void initState() {
   //"ca-app-pub-4028885124199049~1937512750"
     FirebaseAdMob.instance.initialize(appId:"ca-app-pub-4028885124199049~1937512750");
    //Change appId With Admob Id
    // _bannerAd = createBannerAd()
    //   ..load()
    //   ..show();
       super.initState();
  }

  //  void dispose() {
  //   _bannerAd.dispose();
  //   super.dispose();
  // }
  




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
    final _size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: _size.height * 0.10, bottom: 10, left: 10),
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
                        color: Colors.white,
                        shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: _launchURLE,
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                    image: AssetImage('assets/ematricula.png'),
                                    fit: BoxFit.cover),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Ematrícula',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.blue))
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
                        onPressed: _launchURLS,
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                    image: AssetImage('assets/SibdiNegro.png'),
                                    fit: BoxFit.fill),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('SIBDI',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white))
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
                        onPressed: _launchURLO,
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                    image: AssetImage(
                                        'assets/Firma-horizontal-color_red.png'),
                                    fit: BoxFit.fill),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('OBAS',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white))
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
                        color: Colors.white,
                        shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        onPressed: _launchURLSi,
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                    height: 40,
                                    image: AssetImage('assets/banner_sau_2.png'),
                                    fit: BoxFit.cover),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('SAU',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.blue))
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
            SizedBox(
              height: 30,
            ),
            Container(
              
              child: Text('Nota: Cada uno de los siguientes accesos te ayudara de una forma más rapida a encontrar las paginas web de uso general por la población estudiantil.',
              style: TextStyle( color: Colors.blue),
              ))
          ],
        ),
      ),
    );
  }

  _launchURLE() async {
    const url = 'https://ematricula.ucr.ac.cr/ematricula/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLS() async {
    const url = 'http://sibdi.ucr.ac.cr/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLO() async {
    const url = 'https://becassolicitudes.ucr.ac.cr/becas/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLSi() async {
    const url = 'https://admision.ac.cr/sau/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
