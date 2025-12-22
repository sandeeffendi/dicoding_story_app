import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intermediate_first_submission/features/detail/provider/detail_maps_provider.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DetailMapsProvider>().initializeLocation(
        lat: widget.storyLat,
        lon: widget.storyLon,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final LatLng storyCurrentPosition = LatLng(
      widget.storyLat,
      widget.storyLon,
    );

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.locationTitle)),
      body: Center(
        child: Consumer<DetailMapsProvider>(
          builder: (context, mapsProvider, child) {
            return Stack(
              children: [
                GoogleMap(
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  markers: mapsProvider.state.markers,
                  initialCameraPosition: CameraPosition(
                    target: storyCurrentPosition,
                    zoom: 18,
                  ),
                  onMapCreated: (controller) {
                    mapsProvider.setMapController(controller);
                  },
                ),

                if (mapsProvider.state.placemark == null)
                  const SizedBox()
                else
                  Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: PlacemarkWidget(
                      placemark: mapsProvider.state.placemark!,
                    ),
                  ),
              ],
            );
          },
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
