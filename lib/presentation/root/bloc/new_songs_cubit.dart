import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify/presentation/root/bloc/new_songs_state.dart';
import '../../../domain/usecases/song/get_new_songs.dart';
import '../../../service_locator.dart';

class NewSongsCubit extends Cubit<NewSongState>{
  NewSongsCubit() : super(NewSongsLoading());

  Future<void> getNewSongs() async{
    var returnedSongs = await sl<GetNewSongsUseCase>().call();

    returnedSongs.fold(
      (l) {
        emit(NewSongsLoadFailure());
      },
      (data) {
        emit(NewSongsLoaded(songs: data));
      }
    );
  }

}