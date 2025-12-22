import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intermediate_first_submission/features/detail/provider/detail_maps_state.dart';

class DetailMapsProvider extends ChangeNotifier {
  DetailMapsProvider();

  DetailMapsState _state = const DetailMapsState();
  DetailMapsState get state => _state;

  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;

  // set map controller trigger method
  void setMapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  // init location trigger method
  Future<void> initializeLocation({
    required double lat,
    required double lon,
  }) async {
    _state = _state.copyWith(status: DetailMapsStatus.loading);
    notifyListeners();

    try {
      final latLng = LatLng(lat, lon);

      // set initial marker
      final initialMarker = Marker(
        markerId: const MarkerId('source'),
        position: latLng,
      );

      _state = _state.copyWith(markers: {initialMarker});
      notifyListeners();

      // Get placemark info
      final info = await geo.placemarkFromCoordinates(lat, lon);
      final place = info[0];

      // create marker with info
      final street = place.street;
      final address =
          '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

      final marker = Marker(
        markerId: const MarkerId('source'),
        position: latLng,
        infoWindow: InfoWindow(
          title: street ?? 'Unnamed Street',
          snippet: address,
        ),
      );

      _state = _state.copyWith(
        status: DetailMapsStatus.success,
        placemark: place,
        markers: {marker},
      );
    } catch (e) {
      _state = _state.copyWith(
        status: DetailMapsStatus.error,
        message: e.toString(),
      );
    } finally {
      notifyListeners();
    }
  }

  // reset state trigger method
  void reset() {
    _state = const DetailMapsState();
    _mapController = null;
    notifyListeners();
  }
}
