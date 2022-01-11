import 'package:flutter/material.dart';
import 'package:flutter_application_1/google_auth.dart';
import 'package:flutter_application_1/google_map.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';

const String kakaoMapKey = '6f1078e092ca14c60168aec194eb6bef';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Home"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => GoogleMapSearch()));
                },
                child: Text("Google Map")),
            KakaoMapView(
                width: size.width,
                height: 400,
                kakaoMapKey: kakaoMapKey,
                lat: 33.450701,
                lng: 126.570667,
                showMapTypeControl: true,
                showZoomControl: true,
                markerImageURL:
                    'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
                onTapMarker: (message) {
                  //event callback when the marker is tapped
                })
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await authClass.logOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => LoginPage()),
                (route) => false);
          },
          child: Icon(Icons.logout),
        ),
      ),
    );
  }
}
