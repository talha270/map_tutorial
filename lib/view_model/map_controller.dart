import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:map_tutorial/model/services/gomaps_services.dart';
import 'package:uuid/uuid.dart';
class LocationController extends GetxController {
  final Location location = Location(); // Location instance
  var currentLocation = Rxn<LatLng>(); // Observable for user's current location
  final MapController mapController = MapController();
  final TextEditingController searchtextcontroller = TextEditingController();
  var uuid = Uuid();
  String sessiontoken = "11223344";

  // Initialize polylinePoints as an observable list
  var polylinePoints = Rx<List<LatLng>>([]);

  @override
  void onInit() {
    super.onInit();
    _getUserLocation();
    searchtextcontroller.addListener(() {
      onchange();
    });
  }

  void onchange() {
    if (sessiontoken.isEmpty) {
      sessiontoken = uuid.v4();
    }
    getautocomplete(place: searchtextcontroller.text, sessiontoken: sessiontoken);
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location services are enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check for location permissions
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Get the user's current location
    final userLocation = await location.getLocation();
    currentLocation.value = LatLng(userLocation.latitude!, userLocation.longitude!);
    mapController.move(currentLocation.value!, 16.0);

    // Update polylinePoints with the current location
    polylinePoints.value = [
      currentLocation.value!,
      LatLng(37.7749, -122.4194), // Destination point
    ];
  }

  void moveToCurrentLocation() async {
    await _getUserLocation();
    if (currentLocation.value != null) {
      mapController.move(currentLocation.value!, 10.0);
    }
  }
}
