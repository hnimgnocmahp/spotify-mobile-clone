import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_spotify/domain/entities/song/song.dart';

import '../../models/song/song.dart';

abstract class SongFirebaseService{
  Future<Either> getNewSongs();
  Future<Either> getPlaylist();
}

class SongFirebaseServiceImpl implements SongFirebaseService{
  @override
  Future<Either> getNewSongs() async{
    try {
      List<SongEntity> songs= [];

      var data = await FirebaseFirestore.instance.collection('Songs')
            .orderBy('releaseDate', descending: true).limit(6).get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return Left('An error occurred, please try again later.');
    }
  }

  @override
  Future<Either> getPlaylist() async {
    try {
      List<SongEntity> songs= [];

      var data = await FirebaseFirestore.instance.collection('Songs')
          .orderBy('releaseDate', descending: true).limit(6).get();
      print("📥 Đã lấy được ${data.docs.length} documents từ Firestore");

      for (var element in data.docs) {
        print("🧾 Document data: ${element.data()}");
        var songModel = SongModel.fromJson(element.data());
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return Left('An error occurred, please try again later.');
    }
  }

}