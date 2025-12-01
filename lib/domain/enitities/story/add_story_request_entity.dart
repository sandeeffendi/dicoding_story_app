import 'dart:io';

class AddStoryRequestEntity {
  final String description;
  final File photo;
  final double? lat;
  final double? lon;

  AddStoryRequestEntity({
    required this.description,
    required this.photo,
    this.lat,
    this.lon,
  });
}
