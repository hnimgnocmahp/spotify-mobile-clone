import 'package:dartz/dartz.dart';
import 'package:flutter_spotify/core/usecase/usecase.dart';
import 'package:flutter_spotify/domain/repository/song/song.dart';
import '../../../service_locator.dart';

class IsFavouriteSongUseCase implements UseCase<bool, String> {

  @override
  Future<bool> call({String ? params}) async{
    return await sl<SongRepository>().isFavouriteSong(params!);
  }

}