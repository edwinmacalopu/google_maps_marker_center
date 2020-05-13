import 'package:flutter/material.dart';
import 'package:google_maps_marker_center/src/bloc/bloc.dart';
import 'package:google_maps_marker_center/src/page/Gmap_page.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_)=>ProviderMaps()..getUserLocation())
            ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
        theme: ThemeData(
    buttonTheme:ButtonThemeData(
     buttonColor: Colors.blueAccent,
     height:50,
     textTheme: ButtonTextTheme.primary,
     minWidth: 80,
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(10)
     ),

   ) 
        ),
        home: Gmap()
      ),
    );
  }
}