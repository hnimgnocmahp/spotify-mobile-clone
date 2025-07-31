import 'package:dartz/dartz.dart';

import '../../../domain/repository/song/song.dart';
import '../../../service_locator.dart';
import '../../sources/song/song_firebase_service.dart';

class SongRepositoryIml extends SongRepository{
  @override
  Future<Either> getSongs() async {
    return await sl<SongFirebaseService>().getNewSongs();
  }

  @override
  Future<Either> getPlaylist() async {
    return await sl<SongFirebaseService>().getPlaylist();
  }

  @override
  Future<Either> addOrRemoveFavouriteSongs(String songId) async {
    return await sl<SongFirebaseService>().addOrRemoveFavouriteSongs(songId);
  }

  @override
  Future<bool> isFavouriteSong(String songId) async{
    return await sl<SongFirebaseService>().isFavouriteSong(songId);
  }

  @override
  Future<Either> getUserFavouriteSong() async{
    return await sl<SongFirebaseService>().getUserFavouriteSongs();
  }


}