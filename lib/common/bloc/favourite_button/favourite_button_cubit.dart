import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify/common/bloc/favourite_button/favourite_button_state.dart';
import 'package:flutter_spotify/domain/usecases/song/add_or_remove_favourite_song.dart';

import '../../../service_locator.dart';

class FavouriteButtonCubit extends Cubit<FavouriteButtonState>{
  FavouriteButtonCubit(): super(FavouriteButtonInitial());

  void favouriteButtonUpdated(String songId) async{
    var result = await sl<AddOrRemoveFavouriteSongUseCase>().call(params: songId);
    result.fold(
      (l){

      },
      (isFavourite){
        emit(
          FavouriteButtonUpdated(isFavourite: isFavourite)
        );
      }
    );
  }
}