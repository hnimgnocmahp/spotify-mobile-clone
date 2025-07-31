import 'package:flutter_spotify/domain/entities/song/song.dart';

class FavouriteSongsState{}

class FavouriteSongsLoading extends FavouriteSongsState{}

class FavouriteSongsLoaded extends FavouriteSongsState{
  final List<SongEntity> songEntities;
  FavouriteSongsLoaded({required this.songEntities});
}

class FavouriteSongsFailure extends FavouriteSongsState{}