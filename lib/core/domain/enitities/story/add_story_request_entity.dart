import 'dart:io';

class AddStoryRequestEntity {
  final String? description;
  final List<int> photo;
  final double? lat;
  final double? lon;

  AddStoryRequestEntity({
    required this.description,
    required this.photo,
    this.lat,
    this.lon,
  });
}
