import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart' as geo;

class DetailMapsPage extends StatefulWidget {
  const DetailMapsPage({super.key});

  @override
  State<DetailMapsPage> createState() => _DetailMapsPageState();
}

class _DetailMapsPageState extends State<DetailMapsPage> {
  late GoogleMapController mapController;

  final Set<Marker> markers = {};

  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);

  final MapType mapType = MapType.normal;

  @override
  void initState() {
    super.initState();

    final marker = Marker(
      markerId: const MarkerId('Dicoding Office'),
      position: dicodingOffice,
      onTap: () {
        mapController.animateCamera(
          CameraUpdate.newLatLngZoom(dicodingOffice, 18),
        );
      },
    );

    markers.add(marker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.locationTitle)),
      body: Center(
        child: Stack(
          children: [
            GoogleMap(
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,

              mapType: mapType,
              markers: markers,
              initialCameraPosition: CameraPosition(
                target: dicodingOffice,
                zoom: 18,
              ),
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
