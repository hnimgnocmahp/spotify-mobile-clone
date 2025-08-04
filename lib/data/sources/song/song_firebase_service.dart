import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spotify/domain/entities/song/song.dart';
import 'package:flutter_spotify/domain/usecases/song/is_favourite_song.dart';

import '../../../service_locator.dart';
import '../../models/song/song.dart';

abstract class SongFirebaseService{
  Future<Either> getNewSongs();
  Future<Either> getPlaylist();
  Future<Either> addOrRemoveFavouriteSongs(String songId);
  Future<bool> isFavouriteSong(String songId);
  Future<Either> getUserFavouriteSongs();
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
        bool isFavourite = await sl<IsFavouriteSongUseCase>().call(params: element.reference.id);
        songModel.isFavourite = isFavourite;
        songModel.songId = element.reference.id;
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

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavourite = await sl<IsFavouriteSongUseCase>().call(params: element.reference.id);
        songModel.isFavourite = isFavourite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return Left('An error occurred, please try again later.');
    }
  }

  @override
  Future<Either> addOrRemoveFavouriteSongs(String songId) async{
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      late bool isFavourite;

      var user = auth.currentUser;
      String userId = user!.uid;

      QuerySnapshot favouriteSongs = await firestore.collection('Users').doc(userId).collection('Favourites')
        .where('songId', isEqualTo:  songId).get();

      if (favouriteSongs.docs.isNotEmpty) {
        isFavourite = false;
        await favouriteSongs.docs.first.reference.delete();
      }else{
        await firestore.collection('Users').doc(userId).collection('Favourites').add({
          'songId': songId,
          'addDate': Timestamp.now(),
        });
        isFavourite = true;
      }
      return Right(isFavourite);
    } catch (e) {
      return Left('An error occurred');
    }

  }

  @override
  Future<bool> isFavouriteSong(String songId) async{
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      var user = auth.currentUser;
      String userId = user!.uid;

      QuerySnapshot favouriteSongs = await firestore.collection('Users').doc(userId).collection('Favourites')
          .where('songId', isEqualTo: songId).get();

      if (favouriteSongs.docs.isNotEmpty) {
        return true;
      }else{
        return false;
      }
    } catch (e) {
      return false;
    }

  }

  @override
  Future<Either> getUserFavouriteSongs() async{
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String userId = user!.uid;

      List<SongEntity> songs= [];

      QuerySnapshot favouriteSongsSnapshot = await firestore.collection('Users')
        .doc(userId)
        .collection('Favourites')
        .get();

      for (var element in favouriteSongsSnapshot.docs){
        String songId = element['songId'];
        var song = await firestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.songId = song.id;
        songModel.isFavourite = true;
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return Left('An error occurred.');
    }

  }

}