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
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;

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
  List<LatLng> _polylineCoordinates = [];

  // ⚠️ Use your valid "Web Service" Google Maps API key (with Places + Directions enabled)
  static const String _googleAPIKey =
      'AIzaSyYYYCD8bY_JqPR9R6H-PaCp06DMc1dpyFaFbg';

  final TextEditingController _searchController = TextEditingController();
  LatLng? _selectedDestination;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  /// ✅ Get Current Location
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

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = position;
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
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

  /// ✅ Search for nearby places (clinics/pharmacies) within 5 km
  Future<void> _searchAndDisplayNearby(String query) async {
    if (_currentPosition == null || query.isEmpty) return;

    final lat = _currentPosition!.latitude;
    final lng = _currentPosition!.longitude;

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
      '?location=$lat,$lng'
      '&radius=5000'
      '&keyword=${Uri.encodeComponent(query)}'
      '&type=pharmacy|doctor|health|hospital|clinic'
      '&key=$_googleAPIKey',
    );

    final response = await http.get(url);
    if (response.statusCode != 200) {
      debugPrint('Places API HTTP error: ${response.statusCode}');
      return;
    }

    final data = json.decode(response.body);
    if (data['status'] != 'OK') {
      debugPrint('Places API status: ${data['status']}');
      return;
    }

    final List results = data['results'];
    if (results.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No nearby results found.')));
      return;
    }

    // ✅ Limit to top 2 results only
    final topResults = results.take(2).toList();

    setState(() {
      _markers.removeWhere((m) => m.markerId.value.startsWith('item_'));
      for (var place in topResults) {
        final lat = place['geometry']['location']['lat'];
        final lng = place['geometry']['location']['lng'];
        final name = place['name'];
        final id = place['place_id'];

        _markers.add(
          Marker(
            markerId: MarkerId('item_$id'),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: name),
            onTap: () {
              _onDestinationSelected(LatLng(lat, lng), name);
            },
          ),
        );
      }
    });

    // Center map around the found results
    if (topResults.isNotEmpty) {
      final first = topResults.first;
      final lat = first['geometry']['location']['lat'];
      final lng = first['geometry']['location']['lng'];
      _controller?.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(lat, lng), 13.5),
      );
    }
  }

  /// ✅ When user taps a marker
  void _onDestinationSelected(LatLng destLatLng, String name) {
    _selectedDestination = destLatLng;
    _createRoute();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Showing route to $name')));
  }

  /// ✅ Draw route between user location and selected destination
  Future<void> _createRoute() async {
    if (_currentPosition == null || _selectedDestination == null) return;

    final origin = LatLng(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );
    final destination = _selectedDestination!;

    final polylinePoints = PolylinePoints(apiKey: _googleAPIKey);

    final result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(origin.latitude, origin.longitude),
        destination: PointLatLng(destination.latitude, destination.longitude),
        mode: TravelMode.driving,
      ),
    );

    _polylineCoordinates.clear();
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    setState(() {
      _polylines.clear();
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          width: 5,
          color: Colors.blueAccent,
          points: _polylineCoordinates,
        ),
      );
    });

    _controller?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(
            origin.latitude < destination.latitude
                ? origin.latitude
                : destination.latitude,
            origin.longitude < destination.longitude
                ? origin.longitude
                : destination.longitude,
          ),
          northeast: LatLng(
            origin.latitude > destination.latitude
                ? origin.latitude
                : destination.latitude,
            origin.longitude > destination.longitude
                ? origin.longitude
                : destination.longitude,
          ),
        ),
        70,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Medical Map'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          if (_currentPosition == null)
            const Center(child: CircularProgressIndicator())
          else
            GoogleMap(
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
          // 🔍 Search Bar
          Positioned(
            top: 10,
            left: 15,
            right: 15,
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search for clinic or pharmacy...',
                        border: InputBorder.none,
                      ),
                      onSubmitted:
                          (value) => _searchAndDisplayNearby(value.trim()),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed:
                        () => _searchAndDisplayNearby(
                          _searchController.text.trim(),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }
}
