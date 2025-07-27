import 'package:dartz/dartz.dart';
import 'package:flutter_spotify/core/usecase/usecase.dart';
import 'package:flutter_spotify/domain/repository/auth/auth.dart';
import '../../../data/models/auth/create_user_req.dart';
import '../../../service_locator.dart';

class SignupUseCase implements UseCase<Either<String, String>, CreateUserReg> {

  @override
  Future<Either<String, String>> call({required CreateUserReg params}) async{
    return sl<AuthRepository>().signUp(params);
  }

}