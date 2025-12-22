import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum DetailMapsStatus { initial, loading, success, error }

class DetailMapsState {
  final DetailMapsStatus status;
  final String? message;
  final Set<Marker> markers;
  final geo.Placemark? placemark;

  const DetailMapsState({
    this.status = DetailMapsStatus.initial,
    this.message,
    this.markers = const {},
    this.placemark,
  });

  bool get isLoading => status == DetailMapsStatus.loading;
  bool get isError => status == DetailMapsStatus.error;
  bool get isSuccess => status == DetailMapsStatus.success;

  DetailMapsState copyWith({
    DetailMapsStatus? status,
    String? message,
    Set<Marker>? markers,
    geo.Placemark? placemark,
  }) {
    return DetailMapsState(
      status: status ?? this.status,
      message: message ?? this.message,
      markers: markers ?? this.markers,
      placemark: placemark ?? this.placemark,
    );
  }
}
