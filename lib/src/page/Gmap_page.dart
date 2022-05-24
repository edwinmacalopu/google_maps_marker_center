import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_marker_center/src/bloc/bloc.dart';
import 'package:provider/provider.dart';

class Gmap extends StatefulWidget {
  Gmap({Key? key}) : super(key: key);

  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  @override
  Widget build(BuildContext context) {
    final provmaps = Provider.of<ProviderMaps>(context);
    return provmaps.activegps == false
        ? Scaffold(
            body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 250,
                    width: 250,
                    child: Image.asset('assets/images/nogps.png'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'You must activate GPS to get your location',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      provmaps.getUserLocation();
                    },
                    child: Text('try again'),
                  )
                ],
              ),
            ),
          ))
        : Scaffold(
            body: SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: GoogleMap(
                        zoomControlsEnabled: false,
                        mapType: MapType.normal,
                        markers: provmaps.markers,
                        onCameraMove: provmaps.onCameraMove,
                        initialCameraPosition: CameraPosition(
                            target: provmaps.initialPos, zoom: 18.0),
                        onMapCreated: provmaps.onCreated,
                        onCameraIdle: () async {
                          provmaps.getMoveCamera();
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: FloatingActionButton(
                      onPressed: provmaps.getUserLocation,
                      backgroundColor: Colors.blueAccent,
                      child: Icon(
                        Icons.gps_fixed,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  /*,*/
                  Positioned(
                      top: 0,
                      child: Container(
                          color: Colors.white,
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Google Maps",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextField(
                                  maxLines: 1,
                                  controller: provmaps.locationController,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.map),
                                      //hintText: 'CoNstr@seña',
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ],
                            ),
                          ))),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.location_on,
                      size: 50,
                      color: Colors.redAccent,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
