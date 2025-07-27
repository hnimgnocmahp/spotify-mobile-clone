import 'package:dartz/dartz.dart';
import 'package:flutter_spotify/core/usecase/usecase.dart';
import 'package:flutter_spotify/domain/repository/song/song.dart';
import '../../../service_locator.dart';

class GetNewSongsUseCase implements UseCase<Either, dynamic> {

  @override
  Future<Either> call({params}) async{
    return await sl<SongRepository>().getSongs();
  }

}