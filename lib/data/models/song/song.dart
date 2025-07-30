import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spotify/domain/entities/song/song.dart';

class SongModel{
  String ? title;
  String ? artist;
  num ? duration;
  String ? cover_id;
  String ? song_id;
  Timestamp ? releaseDate;
  bool ? isFavourite;
  String ? songId;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.cover_id,
    required this.song_id,
    required this.releaseDate,
    required this.isFavourite,
    required this.songId,
  });

  SongModel.fromJson(Map<String, dynamic> json){
    title = json['title'];
    artist = json['artist'];
    duration = json['duration'];
    cover_id = json['cover_id'];
    song_id = json['song_id'];
    releaseDate = json['releaseDate'];
    isFavourite = json['isFavourite'];
    songId = json['songId'];
  }

}

extension SongModelExtension on SongModel{
  SongEntity toEntity(){
    return SongEntity(
      title: title!,
      artist: artist!,
      duration: duration!,
      cover_id: cover_id!,
      song_id: song_id!,
      releaseDate: releaseDate!,
      isFavourite: isFavourite!,
      songId: songId!,
    );
  }
}