import 'package:flutter_spotify/data/models/auth/signing_user_reg.dart';
import 'package:flutter_spotify/data/repository/song/song_repository_impl.dart';
import 'package:flutter_spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:flutter_spotify/data/sources/song/song_firebase_service.dart';
import 'package:flutter_spotify/domain/repository/auth/auth.dart';
import 'package:flutter_spotify/domain/usecases/auth/signin.dart';
import 'package:flutter_spotify/domain/usecases/auth/signup.dart';
import 'package:flutter_spotify/domain/usecases/song/add_or_remove_favourite_song.dart';
import 'package:flutter_spotify/domain/usecases/song/get_new_songs.dart';
import 'package:flutter_spotify/domain/usecases/song/get_play_list.dart';
import 'package:flutter_spotify/domain/usecases/song/is_favourite_song.dart';
import 'package:get_it/get_it.dart';

import 'data/repository/auth/auth_repository_impl.dart';
import 'domain/repository/song/song.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async{
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<SongFirebaseService>(
    SongFirebaseServiceImpl()
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  sl.registerSingleton<SongRepository>(
    SongRepositoryIml()
  );

  sl.registerSingleton<SignupUseCase>(
    SignupUseCase()
  );

  sl.registerSingleton<SignInUseCase>(
    SignInUseCase()
  );

  sl.registerSingleton<GetNewSongsUseCase>(
    GetNewSongsUseCase()
  );

  sl.registerSingleton<GetPlaylistUseCase>(
      GetPlaylistUseCase()
  );

  sl.registerSingleton<AddOrRemoveFavouriteSongUseCase>(
      AddOrRemoveFavouriteSongUseCase()
  );

  sl.registerSingleton<IsFavouriteSongUseCase>(
      IsFavouriteSongUseCase()
  );

}