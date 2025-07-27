import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity{
  String title;
  String artist;
  num duration;
  String cover_id;
  Timestamp releaseDate;

  SongEntity({required this.title, required this.artist, required this.duration, required this.cover_id, required this.releaseDate});
}