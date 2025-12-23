import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum PostLocationStatus { initial, loading, success, error }

class PostLocationState {
  final PostLocationStatus status;
  final String? message;
  final double? lat;
  final double? lon;
  final Set<Marker> markers;
  final geo.Placemark? placemark;

  const PostLocationState({
    this.status = PostLocationStatus.initial,
    this.message,
    this.lat,
    this.lon,
    this.markers = const {},
    this.placemark,
  });

  bool get isLoading => status == PostLocationStatus.loading;
  bool get isError => status == PostLocationStatus.error;
  bool get isSuccess => status == PostLocationStatus.success;

  PostLocationState copyWith({
    PostLocationStatus? status,
    String? message,
    double? lat,
    double? lon,
    Set<Marker>? markers,
    geo.Placemark? placemark,
  }) {
    return PostLocationState(
      status: status ?? this.status,
      message: message ?? this.message,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      markers: markers ?? this.markers,
      placemark: placemark ?? this.placemark,
    );
  }
}
