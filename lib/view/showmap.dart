import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_tutorial/view_model/theme_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../view_model/map_controller.dart';

class GoMapsPage extends StatelessWidget {
  final controller=Get.find<ThemeController>();
  final getxmap=Get.put(LocationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Obx(
              ()=> FlutterMap(
                mapController: getxmap.mapController,
                options: MapOptions (
                  initialCenter: LatLng(37.7749, -122.4194), // Initial location (San Francisco)
                  initialZoom: 14,

                ),
                children: [
                  // Tile layer to display the map
                  TileLayer(
                    urlTemplate: dotenv.env["openstreetmapurl"],
                    userAgentPackageName: 'com.example.app',
                  ),
                  if(getxmap.polylinePoints!.value!.isNotEmpty)
                    PolylineLayer(polylines: [
                      Polyline(points: getxmap.polylinePoints!.value!,color: Colors.blue,strokeWidth: 4)
                    ]),
                  if (getxmap.currentLocation.value != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: getxmap.currentLocation.value!,
                          width: 80,
                          height: 80,
                          child: Icon(
                            Icons.my_location,
                            size: 40,
                            color: Colors.blue,
                          ),
                        ),
                        Marker(point:LatLng(37.7749, -122.4194), child: Icon(Icons.location_pin,color: Colors.red,))
                      ],
                    ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 20,
              child: Obx(
                ()=> Container(
                  height: 50,
                  width: Get.width-40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: LinearGradient(colors: [
                        Colors.black,
                        controller.isDarkMode.value?Colors.blueAccent:Colors.orange
                      ]),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 15,),
                      Text("flutter_map",style: TextStyle(color: Colors.white,fontSize: 16),),
                      Spacer(),
                      Obx(
                        ()=> IconButton(onPressed: () {
                          controller.toggleTheme();
                        }, icon: Icon(controller.isDarkMode.value?Icons.dark_mode:Icons.light_mode_outlined,)),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        ()=> FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: controller.isDarkMode.value?Colors.blueAccent:Colors.orange,
          child: Icon(Icons.my_location),
          onPressed: () {
            print("onpressed");
            getxmap.moveToCurrentLocation();
          },
        ),
      ),
    );
  }
}

