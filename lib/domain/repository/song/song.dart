import 'package:dartz/dartz.dart';

abstract class SongRepository{
  Future<Either> getSongs();
  Future<Either> getPlaylist();
  Future<Either> addOrRemoveFavouriteSongs(String songId);
  Future<bool> isFavouriteSong(String songId);
  Future<Either> getUserFavouriteSong();
}