import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify/domain/usecases/song/get_favourite_songs.dart';
import '../../../service_locator.dart';
import 'favourite_songs_state.dart';

class FavouriteSongsCubit extends Cubit<FavouriteSongsState>{
  FavouriteSongsCubit(): super(FavouriteSongsLoading());

  Future<void> loadFavouriteSongs()async {
    var user = await sl<GetFavouriteSongsUseCase>().call();

    user.fold(
      (l) {
        print('$l');
        emit(FavouriteSongsFailure());
      },
      (listSongs) {
        emit(FavouriteSongsLoaded(songEntities: listSongs));
      }
    );
  }

}