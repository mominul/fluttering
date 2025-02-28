import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  String id;
  final String title;
  // final PlaceLocation location;
  late File image;

  Place({
    required this.title,
    // required this.location,
    required this.image,
    id,
  }): id = id ?? uuid.v4();
}
