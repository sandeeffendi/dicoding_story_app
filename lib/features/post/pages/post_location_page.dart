import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';
import 'package:location/location.dart';

class PostLocationPage extends StatefulWidget {
  const PostLocationPage({super.key});

  @override
  State<PostLocationPage> createState() => _PostLocationPageState();
}

class _PostLocationPageState extends State<PostLocationPage> {
  double? _storyLat;
  double? _storylon;
  Completer<GoogleMapController> _mapController = Completer();
  geo.Placemark? placemark;
  final Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    // init default location
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final Location location = Location();
      late bool serviceEnabled;
      late PermissionStatus permissionGranted;
      late LocationData locationData;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          print('Service is not available');
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          print('Location permission denied');
          return;
        }
      }

      // get location data
      locationData = await location.getLocation();

      _storyLat = locationData.latitude;
      _storylon = locationData.longitude;

      final LatLng latLng = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );

      final info = await geo.placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );

      final place = info[0];
      final street = place.street;
      final String address =
          '${place.subLocality}, ${place.locality},${place.postalCode},${place.country}';

      setState(() {
        placemark = place;
      });

      defineMarker(latLng, street, address);

      final controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLng(latLng));
    });
  }

  void defineMarker(LatLng latLng, String? street, String address) {
    final marker = Marker(
      markerId: const MarkerId('source'),
      position: latLng,
      infoWindow: InfoWindow(
        title: street ?? 'Unknown Street',
        snippet: address,
      ),
    );

    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  void onLongPressGoogleMaps(LatLng latLng) async {
    final selectedLocation = LatLng(latLng.latitude, latLng.longitude);

    final info = await geo.placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );

    final place = info[0];
    final street = place.street;
    final String address =
        '${place.subLocality}, ${place.locality},${place.postalCode},${place.country}';

    setState(() {
      placemark = place;
    });

    defineMarker(selectedLocation, street, address);

    final controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLng(selectedLocation));
  }

  void onMyLocationButtonPress() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print('Service is not available');
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print('Location permission denied');
        return;
      }
    }

    // get location data
    locationData = await location.getLocation();

    _storyLat = locationData.latitude;
    _storylon = locationData.longitude;

    final LatLng latLng = LatLng(
      locationData.latitude!,
      locationData.longitude!,
    );

    final info = await geo.placemarkFromCoordinates(
      locationData.latitude!,
      locationData.longitude!,
    );

    final place = info[0];
    final street = place.street;
    final String address =
        '${place.subLocality}, ${place.locality},${place.postalCode},${place.country}';

    setState(() {
      placemark = place;
    });

    defineMarker(latLng, street, address);

    final controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  @override
  Widget build(BuildContext context) {
    final LatLng currentLocation = LatLng(_storyLat ?? 0, _storylon ?? 0);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.locationTitle)),
      body: Center(
        child: Stack(
          children: [
            GoogleMap(
              markers: markers,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,

              onLongPress: (LatLng latLng) {
                onLongPressGoogleMaps(latLng);
              },
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 18,
              ),
              onMapCreated: (controller) async {
                _mapController.complete(controller);
              },
            ),

            // on my location button
            Positioned(
              top: 16,
              right: 16,
              child: FloatingActionButton(
                heroTag: 'My Location',
                tooltip: 'My Location',

                onPressed: () {
                  onMyLocationButtonPress();
                },

                child: Icon(Icons.my_location),
              ),
            ),

            // placemark widget
            if (placemark == null)
              const SizedBox()
            else
              Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: PlacemarkWidget(placemark: placemark!),
              ),
          ],
        ),
      ),
    );
  }
}

class PlacemarkWidget extends StatelessWidget {
  const PlacemarkWidget({super.key, required this.placemark});
  final geo.Placemark placemark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(maxWidth: 700),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 20,
            offset: Offset.zero,
            color: Colors.grey.withAlpha((0.5 * 255).round()),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  placemark.street!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
