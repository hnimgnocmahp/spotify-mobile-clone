import 'package:dartz/dartz.dart';
import 'package:flutter_spotify/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';
import '../../models/auth/create_user_req.dart';
import '../../models/auth/signing_user_reg.dart';
import '../../sources/auth/auth_firebase_service.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either<String, String>> signIn(SigningUserReg signingUserReg) async {
    return await sl<AuthFirebaseService>().signin(signingUserReg);
  }

  @override
  Future<Either<String, String>> signUp(CreateUserReg createUserReg) async {
    return await sl<AuthFirebaseService>().signup(createUserReg);
  }

  @override
  Future<Either> getUser() async{
    return await sl<AuthFirebaseService>().getUser();
  }

}