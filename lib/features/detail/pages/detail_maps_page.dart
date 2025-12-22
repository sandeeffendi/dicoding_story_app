import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart' as geo;

class DetailMapsPage extends StatefulWidget {
  final double storyLat;
  final double storyLon;

  const DetailMapsPage({
    super.key,
    required this.storyLat,

    required this.storyLon,
  });

  @override
  State<DetailMapsPage> createState() => _DetailMapsPageState();
}

class _DetailMapsPageState extends State<DetailMapsPage> {
  late GoogleMapController mapController;

  final Set<Marker> markers = {};

  final currentPosition = const LatLng(-6.8957473, 107.6337669);

  final MapType mapType = MapType.normal;

  geo.Placemark? placemark;

  @override
  void initState() {
    super.initState();

    final currentPositiion = LatLng(widget.storyLat, widget.storyLon);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final LatLng latLng = LatLng(widget.storyLat, widget.storyLon);

      final info = await geo.placemarkFromCoordinates(
        widget.storyLat,
        widget.storyLon,
      );

      final place = info[0];
      final street = place.street;
      final String address =
          '${place.subLocality}, ${place.locality},${place.postalCode},${place.country}';

      setState(() {
        placemark = place;
      });

      defineMarker(latLng, street, address);
    });

    final marker = Marker(
      markerId: const MarkerId('source'),
      position: currentPositiion,
    );

    markers.add(marker);
  }

  // define marker
  void defineMarker(LatLng latLng, String? street, String address) {
    final Marker marker = Marker(
      markerId: const MarkerId('source'),
      position: latLng,
      infoWindow: InfoWindow(
        title: street ?? 'Unnamed Street',
        snippet: address,
      ),
    );

    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  // onCurentLocationMarkerPress
  void onCurrentLocationPress() {}

  @override
  Widget build(BuildContext context) {
    final LatLng storyCurrentPosition = LatLng(
      widget.storyLat,
      widget.storyLon,
    );

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
                target: storyCurrentPosition,
                zoom: 18,
              ),
              onMapCreated: (controller) async {
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
