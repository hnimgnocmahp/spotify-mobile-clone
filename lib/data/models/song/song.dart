import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spotify/domain/entities/song/song.dart';

class SongModel{
  String ? title;
  String ? artist;
  num ? duration;
  String ? cover_id;
  Timestamp ? releaseDate;

  SongModel({required this.title, required this.artist, required this.duration, required this.cover_id, required this.releaseDate});

  SongModel.fromJson(Map<String, dynamic> json){
    title = json['title'];
    artist = json['artist'];
    duration = json['duration'];
    cover_id = json['cover_id'];
    releaseDate = json['releaseDate'];
  }

}

extension SongModelExtension on SongModel{
  SongEntity toEntity(){
    return SongEntity(title: title!, artist: artist!, duration: duration!, cover_id: cover_id!, releaseDate: releaseDate!);
  }
}