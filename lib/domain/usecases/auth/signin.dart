import 'package:dartz/dartz.dart';
import 'package:flutter_spotify/core/usecase/usecase.dart';
import 'package:flutter_spotify/data/models/auth/signing_user_reg.dart';
import 'package:flutter_spotify/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class SignInUseCase implements UseCase<Either<String, String>, SigningUserReg> {

  @override
  Future<Either<String, String>> call({required SigningUserReg params}) async{
    return sl<AuthRepository>().signIn(params);
  }

}