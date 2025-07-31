import 'package:dartz/dartz.dart';
import 'package:flutter_spotify/core/usecase/usecase.dart';
import 'package:flutter_spotify/data/models/auth/signing_user_reg.dart';
import 'package:flutter_spotify/data/models/auth/user.dart';
import 'package:flutter_spotify/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class GetCurrentUserUseCase implements UseCase<Either, UserModel> {

  @override
  Future<Either> call({UserModel? params}) async{
    return sl<AuthRepository>().getUser();
  }

}