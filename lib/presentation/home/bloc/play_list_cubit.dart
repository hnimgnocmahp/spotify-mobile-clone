import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify/domain/usecases/song/get_play_list.dart';
import 'package:flutter_spotify/presentation/home/bloc/play_list_state.dart';
import '../../../service_locator.dart';

class PlaylistCubit extends Cubit<PlaylistState>{
 PlaylistCubit() : super(PlaylistLoading());

  Future<void> getNewSongs() async{
    var returnedSongs = await sl<GetPlaylistUseCase>().call();

    returnedSongs.fold(
      (l) {
        emit(PlaylistLoadFailure());
      },
      (data) {
        emit(PlaylistLoaded(songs: data));
      }
    );
  }

}