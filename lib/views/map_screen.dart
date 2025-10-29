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
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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

  static const String _geoapifyKey = '5a5fd3d21928495b801e02bcd6d3c4f0';
  LatLng? _selectedDestination;

  // ✅ Mapping keywords to Geoapify healthcare categories
  final Map<String, String> _healthcareCategoryMap = {
    "hospital": "healthcare.hospital",
    "clinic": "healthcare.clinic",
    "doctor": "healthcare.doctor",
    "dentist": "healthcare.dentist",
    "pharmacy": "healthcare.pharmacy",
    "optician": "healthcare.optician",
    "laboratory": "healthcare.laboratory",
    "rehabilitation": "healthcare.rehabilitation",
    "veterinary": "healthcare.veterinary",
    "blood donation": "healthcare.blood_donation",
    "ambulance": "healthcare.ambulance_station",
    "nursing home": "healthcare.nursing_home",
    "hospice": "healthcare.hospice",
    "therapist": "healthcare.therapist",
    "psychotherapist": "healthcare.psychotherapist",
  };

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  /// ✅ Get current user location
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
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(title: "You are here"),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
        ),
      );
    });

    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.5,
        ),
      ),
    );
  }

  /// ✅ Search nearby healthcare places by category
  Future<void> _searchNearbyHealthcare() async {
    if (_currentPosition == null) return;
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a healthcare type")),
      );
      return;
    }

    // Find matching category
    String? category =
        _healthcareCategoryMap.entries
            .firstWhere(
              (entry) => query.contains(entry.key),
              orElse: () => const MapEntry("healthcare", "healthcare"),
            )
            .value;

    final lat = _currentPosition!.latitude;
    final lon = _currentPosition!.longitude;

    final url =
        'https://api.geoapify.com/v2/places?categories=$category&filter=circle:$lon,$lat,5000&limit=30&apiKey=$_geoapifyKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final features = data['features'] as List?;
        if (features == null || features.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No nearby places found for this category.'),
            ),
          );
          return;
        }

        final newMarkers = <Marker>{};
        for (var feature in features) {
          final props = feature['properties'];
          final name = props['name'] ?? 'Unknown Facility';
          final lat = feature['geometry']['coordinates'][1];
          final lng = feature['geometry']['coordinates'][0];
          final address = props['formatted'] ?? '';

          newMarkers.add(
            Marker(
              markerId: MarkerId('place_$lat$lng'),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: name, snippet: address),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
              onTap: () => _onDestinationSelected(LatLng(lat, lng), name),
            ),
          );
        }

        setState(() {
          _markers
            ..removeWhere((m) => m.markerId.value.startsWith('place_'))
            ..addAll(newMarkers);
        });

        _controller?.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(
              features.first['geometry']['coordinates'][1],
              features.first['geometry']['coordinates'][0],
            ),
            13,
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Found ${features.length} places for "$query"!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Search error: $e')));
    }
  }

  /// ✅ Create route and show step-by-step directions
  Future<void> _createRoute() async {
    if (_currentPosition == null || _selectedDestination == null) return;

    final url =
        'https://api.geoapify.com/v1/routing?waypoints=${_currentPosition!.latitude},${_currentPosition!.longitude}|${_selectedDestination!.latitude},${_selectedDestination!.longitude}&mode=drive&apiKey=$_geoapifyKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final coords =
            data['features'][0]['geometry']['coordinates'][0] as List;
        final routePoints = coords.map((c) => LatLng(c[1], c[0])).toList();

        setState(() {
          _polylines.clear();
          _polylines.add(
            Polyline(
              polylineId: const PolylineId('route'),
              width: 6,
              color: Colors.blueAccent,
              points: routePoints,
            ),
          );
        });

        // ✅ Automatically zoom to show entire route
        _fitMapToRoute(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          _selectedDestination!,
        );

        // ✅ Show step-by-step directions in bottom sheet
        final steps =
            data['features'][0]['properties']['legs'][0]['steps'] as List;
        final directionSteps =
            steps.map((s) => s['instruction']['text'] ?? '').toList();

        if (context.mounted) {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            builder:
                (_) => ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: directionSteps.length,
                  itemBuilder:
                      (context, index) => ListTile(
                        leading: const Icon(
                          Icons.directions,
                          color: Colors.blueAccent,
                        ),
                        title: Text(directionSteps[index]),
                      ),
                ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Route error: $e')));
    }
  }

  /// ✅ Adjust map to show full route
  void _fitMapToRoute(LatLng start, LatLng end) {
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        start.latitude < end.latitude ? start.latitude : end.latitude,
        start.longitude < end.longitude ? start.longitude : end.longitude,
      ),
      northeast: LatLng(
        start.latitude > end.latitude ? start.latitude : end.latitude,
        start.longitude > end.longitude ? start.longitude : end.longitude,
      ),
    );
    _controller?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
  }

  /// ✅ Open Google Maps navigation
  Future<void> _launchGoogleMapsNavigation(LatLng destination) async {
    final Uri uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${destination.latitude},${destination.longitude}&travelmode=driving',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch Google Maps')),
      );
    }
  }

  void _onDestinationSelected(LatLng dest, String name) {
    _selectedDestination = dest;
    _createRoute();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Showing route to $name'),
        action: SnackBarAction(
          label: 'Navigate',
          onPressed: () => _launchGoogleMapsNavigation(dest),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                zoom: 14.5,
              ),
              onMapCreated: (controller) => _controller = controller,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              markers: _markers,
              polylines: _polylines,
            ),

          /// 🔍 Search Bar
          Positioned(
            top: 40,
            left: 15,
            right: 15,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText:
                            "Enter healthcare type (e.g. hospital, dentist, lab)",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.redAccent),
                    onPressed: _searchNearbyHealthcare,
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
