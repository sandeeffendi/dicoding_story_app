import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intermediate_first_submission/features/post/provider/post_location_provider.dart';
import 'package:intermediate_first_submission/generated/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class PostLocationPage extends StatefulWidget {
  const PostLocationPage({super.key});

  @override
  State<PostLocationPage> createState() => _PostLocationPageState();
}

class _PostLocationPageState extends State<PostLocationPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostLocationProvider>().initializeUserLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.locationTitle)),
      body: Center(
        child: Consumer<PostLocationProvider>(
          builder: (context, provider, child) {
            final state = provider.state;
            final LatLng currentLocation = LatLng(
              state.lat ?? 0,
              state.lon ?? 0,
            );

            return Stack(
              children: [
                GoogleMap(
                  markers: state.markers,
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                  onLongPress: (LatLng latLng) {
                    provider.selectLocation(latLng);
                  },
                  myLocationButtonEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: currentLocation,
                    zoom: 18,
                  ),
                  onMapCreated: (controller) {
                    provider.setMapController(controller);
                  },
                ),

                // my location button
                Positioned(
                  top: 16,
                  right: 16,
                  child: FloatingActionButton(
                    heroTag: 'My Location',
                    tooltip: 'My Location',
                    onPressed: () {
                      provider.goToMyLocation();
                    },
                    child: const Icon(Icons.my_location),
                  ),
                ),

                // placemark widget
                if (state.placemark == null)
                  const SizedBox()
                else
                  Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: PlacemarkWidget(placemark: state.placemark!),
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
