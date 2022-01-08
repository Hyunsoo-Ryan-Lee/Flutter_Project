import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapSearch extends StatefulWidget {
  const GoogleMapSearch({Key? key}) : super(key: key);

  @override
  _GoogleMapSearchState createState() => _GoogleMapSearchState();
}

class _GoogleMapSearchState extends State<GoogleMapSearch> {
  static const _initalCameraPosition =
      CameraPosition(target: LatLng(37.6204206, 126.6990204), zoom: 11.5);

  late GoogleMapController _googleMapController;
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initalCameraPosition,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(_initalCameraPosition)),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
