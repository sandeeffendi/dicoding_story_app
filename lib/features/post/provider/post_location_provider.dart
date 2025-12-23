import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intermediate_first_submission/features/post/provider/post_location_state.dart';
import 'package:intermediate_first_submission/features/post/provider/post_provider.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class PostLocationProvider extends ChangeNotifier {
  PostLocationProvider();

  PostLocationState _state = const PostLocationState();
  PostLocationState get state => _state;

  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;

  // set map controller
  void setMapController(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  // initialize user location on page load
  Future<void> initializeUserLocation() async {
    _state = _state.copyWith(status: PostLocationStatus.loading);
    notifyListeners();

    try {
      final Location location = Location();
      late bool serviceEnabled;
      late PermissionStatus permissionGranted;
      late LocationData locationData;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          _state = _state.copyWith(
            status: PostLocationStatus.error,
            message: 'Location service is not available',
          );
          notifyListeners();
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          _state = _state.copyWith(
            status: PostLocationStatus.error,
            message: 'Location permission denied',
          );
          notifyListeners();
          return;
        }
      }

      // get location data
      locationData = await location.getLocation();

      final latLng = LatLng(locationData.latitude!, locationData.longitude!);

      // get placemark info
      final info = await geo.placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );

      final place = info[0];
      final street = place.street;
      final address =
          '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

      // create marker
      final marker = Marker(
        markerId: const MarkerId('source'),
        position: latLng,
        infoWindow: InfoWindow(
          title: street ?? 'Unknown Street',
          snippet: address,
        ),
      );

      _state = _state.copyWith(
        status: PostLocationStatus.success,
        lat: locationData.latitude,
        lon: locationData.longitude,
        placemark: place,
        markers: {marker},
      );

      // animate camera to location
      if (_mapController != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLng(latLng));
      }
    } catch (e) {
      _state = _state.copyWith(
        status: PostLocationStatus.error,
        message: e.toString(),
      );
    } finally {
      notifyListeners();
    }
  }

  // select location by long press on map
  Future<void> selectLocation(LatLng latLng) async {
    try {
      final info = await geo.placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      final place = info[0];
      final street = place.street;
      final address =
          '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

      final marker = Marker(
        markerId: const MarkerId('source'),
        position: latLng,
        infoWindow: InfoWindow(
          title: street ?? 'Unknown Street',
          snippet: address,
        ),
      );

      _state = _state.copyWith(
        lat: latLng.latitude,
        lon: latLng.longitude,
        placemark: place,
        markers: {marker},
      );

      // animate camera to selected location
      if (_mapController != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLng(latLng));
      }
    } catch (e) {
      _state = _state.copyWith(
        status: PostLocationStatus.error,
        message: e.toString(),
      );
    } finally {
      notifyListeners();
    }
  }

  // go to my location (current GPS)
  Future<void> goToMyLocation() async {
    await initializeUserLocation();
  }

  void disposeResource() {
    _mapController?.dispose();
    _mapController = null;
  }

  // reset state
  void reset() {
    _state = const PostLocationState();
    _mapController?.dispose();
    _mapController = null;
    notifyListeners();
  }

  // confirm selected location
  void confirmSelectedLocation(BuildContext context) {
    if (_state.lat != null && _state.lon != null) {
      final provider = context.read<PostProvider>();
      provider.setSelectedLocation(
        lat: _state.lat!,
        lon: _state.lon!,
        locationName: _state.placemark?.name,
      );
      context.pop();
    }
  }
}
