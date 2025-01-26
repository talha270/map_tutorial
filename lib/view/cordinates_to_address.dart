import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class CoordinatesAddressConverter extends StatefulWidget {
  @override
  _CoordinatesAddressConverterState createState() =>
      _CoordinatesAddressConverterState();
}

class _CoordinatesAddressConverterState
    extends State<CoordinatesAddressConverter> {
  String address = "Address";
  String coordinates = "Coordinates";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geocoding Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(address),
            ElevatedButton(
              onPressed: () async {
                try {
                  List<Placemark> placemarks =
                      await placemarkFromCoordinates(52.2165157, 6.9437819);
                  if (placemarks.isNotEmpty) {
                    Placemark place = placemarks.first;
                    setState(() {
                      address =
                          "Address: ${place.name}, ${place.locality}, ${place.country}";
                    });
                  }
                } catch (e) {
                  setState(() {
                    address = "Error: $e";
                    print(e);
                  });
                }
              },
              child: Text("Convert Coordinates to Address"),
            ),
            SizedBox(height: 20),
            Text(coordinates),
            ElevatedButton(
              onPressed: () async {
                try {
                  List<Location> locations =
                      await locationFromAddress("Eiffel Tower, Paris");
                  if (locations.isNotEmpty) {
                    Location location = locations.first;
                    setState(() {
                      coordinates =
                          "Coordinates: ${location.latitude}, ${location.longitude}";
                    });
                  }
                } catch (e) {
                  setState(() {
                    coordinates = "Error: $e";
                  });
                }
              },
              child: Text("Convert Address to Coordinates"),
            ),
          ],
        ),
      ),
    );
  }
}
