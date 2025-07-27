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

}