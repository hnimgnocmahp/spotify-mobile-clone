import 'package:dartz/dartz.dart';
import 'package:flutter_spotify/core/usecase/usecase.dart';
import 'package:flutter_spotify/domain/repository/song/song.dart';
import '../../../service_locator.dart';

class AddOrRemoveFavouriteSongUseCase implements UseCase<Either, String> {

  @override
  Future<Either> call({String ? params}) async{
    return await sl<SongRepository>().addOrRemoveFavouriteSongs(params!);
  }

}