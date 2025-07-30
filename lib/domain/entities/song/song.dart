import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity{
  String title;
  String artist;
  num duration;
  String cover_id;
  String song_id;
  Timestamp releaseDate;
  bool isFavourite;
  String songId;

  SongEntity({
    required this.title,
    required this.artist,
    required this.duration,
    required this.cover_id,
    required this.song_id,
    required this.releaseDate,
    required this.isFavourite,
    required this.songId,
  });
}