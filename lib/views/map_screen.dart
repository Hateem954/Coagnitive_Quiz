// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

// class GoogleMapPage extends StatefulWidget {
//   const GoogleMapPage({super.key});

//   @override
//   State<GoogleMapPage> createState() => _GoogleMapPageState();
// }

// class _GoogleMapPageState extends State<GoogleMapPage> {
//   GoogleMapController? _controller;
//   Position? _currentPosition;
//   final Set<Marker> _markers = {};

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   Future<void> _getCurrentLocation() async {
//     // Check permission
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       await Geolocator.openLocationSettings();
//       return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) return;
//     }

//     if (permission == LocationPermission.deniedForever) return;

//     // Get current position
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     setState(() {
//       _currentPosition = position;
//       _markers.add(
//         Marker(
//           markerId: const MarkerId('currentLocation'),
//           position: LatLng(position.latitude, position.longitude),
//           infoWindow: const InfoWindow(title: "You are here"),
//         ),
//       );
//     });

//     _controller?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(position.latitude, position.longitude),
//           zoom: 15.5,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Live Location Map'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body:
//           _currentPosition == null
//               ? const Center(child: CircularProgressIndicator())
//               : GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: LatLng(
//                     _currentPosition!.latitude,
//                     _currentPosition!.longitude,
//                   ),
//                   zoom: 15.5,
//                 ),
//                 myLocationEnabled: true,
//                 myLocationButtonEnabled: true,
//                 onMapCreated: (controller) => _controller = controller,
//                 markers: _markers,
//               ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _getCurrentLocation,
//         backgroundColor: Colors.blueAccent,
//         child: const Icon(Icons.my_location, color: Colors.white),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  GoogleMapController? _controller;
  Position? _currentPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final TextEditingController _searchController = TextEditingController();

  List<dynamic> _placePredictions = []; // 🔍 Suggestions list

  // 🔑 Your Google API Key (make sure Places + Routes API enabled)
  final String _googleApiKey = "AIzaSyBoJie2FJyNdvygmRHZSB4aw4w9gQFvez8";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  /// 📍 Get current location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = position;
      _markers.add(
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(title: "You are here"),
        ),
      );
    });

    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15.5,
        ),
      ),
    );
  }

  /// 🔍 Get autocomplete suggestions
  Future<void> _getPlacePredictions(String input) async {
    if (input.isEmpty) {
      setState(() => _placePredictions = []);
      return;
    }

    final url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$_googleApiKey&components=country:pk"; // limit to Pakistan

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() => _placePredictions = data["predictions"]);
    }
  }

  /// 📍 Handle place selection from suggestions
  Future<void> _selectPlace(String placeId, String description) async {
    setState(() => _placePredictions = []);
    _searchController.text = description;

    final detailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_googleApiKey";
    final response = await http.get(Uri.parse(detailsUrl));
    final data = jsonDecode(response.body);

    if (data["status"] == "OK") {
      final location = data["result"]["geometry"]["location"];
      final destination = LatLng(location["lat"], location["lng"]);

      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId("destination"),
            position: destination,
            infoWindow: InfoWindow(title: description),
          ),
        );
      });

      await _drawRoute(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        destination,
      );

      _controller?.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(
              _currentPosition!.latitude <= destination.latitude
                  ? _currentPosition!.latitude
                  : destination.latitude,
              _currentPosition!.longitude <= destination.longitude
                  ? _currentPosition!.longitude
                  : destination.longitude,
            ),
            northeast: LatLng(
              _currentPosition!.latitude >= destination.latitude
                  ? _currentPosition!.latitude
                  : destination.latitude,
              _currentPosition!.longitude >= destination.longitude
                  ? _currentPosition!.longitude
                  : destination.longitude,
            ),
          ),
          80,
        ),
      );
    }
  }

  /// 🚗 Draw route using Google Routes API
  Future<void> _drawRoute(LatLng origin, LatLng destination) async {
    final url = "https://routes.googleapis.com/directions/v2:computeRoutes";

    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": _googleApiKey,
      },
      body: jsonEncode({
        "origin": {
          "location": {
            "latLng": {
              "latitude": origin.latitude,
              "longitude": origin.longitude,
            },
          },
        },
        "destination": {
          "location": {
            "latLng": {
              "latitude": destination.latitude,
              "longitude": destination.longitude,
            },
          },
        },
        "travelMode": "DRIVE",
        "routingPreference": "TRAFFIC_AWARE",
        "polylineQuality": "OVERVIEW",
      }),
    );

    final data = jsonDecode(response.body);

    if (data["routes"] != null && data["routes"].isNotEmpty) {
      final encodedPolyline = data["routes"][0]["polyline"]["encodedPolyline"];
      final decodedPoints = PolylinePoints.decodePolyline(encodedPolyline);

      setState(() {
        _polylines.clear();
        _polylines.add(
          Polyline(
            polylineId: const PolylineId("route"),
            color: Colors.blueAccent,
            width: 6,
            points:
                decodedPoints
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No route found")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _currentPosition == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    _currentPosition!.latitude,
                    _currentPosition!.longitude,
                  ),
                  zoom: 15.5,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: (controller) => _controller = controller,
                markers: _markers,
                polylines: _polylines,
              ),

          // 🔍 Search bar
          Positioned(
            top: 40,
            left: 15,
            right: 15,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: "Search destination...",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search, color: Colors.blueAccent),
                    ),
                    onChanged: _getPlacePredictions,
                  ),
                ),

                // 🧭 Suggestions list
                if (_placePredictions.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 4),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: _placePredictions.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final place = _placePredictions[index];
                        return ListTile(
                          leading: const Icon(
                            Icons.location_on,
                            color: Colors.blueAccent,
                          ),
                          title: Text(place["description"]),
                          onTap:
                              () => _selectPlace(
                                place["place_id"],
                                place["description"],
                              ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
