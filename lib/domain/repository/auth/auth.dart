import 'package:dartz/dartz.dart';
import '../../../data/models/auth/create_user_req.dart';
import '../../../data/models/auth/signing_user_reg.dart';

abstract class AuthRepository {
  Future<Either<String, String>> signUp(CreateUserReg createUserReg);
  Future<Either<String, String>> signIn(SigningUserReg signingUserReg);
  // Future<void> signOut();
  // Future<void> resetPassword();
  Future<Either> getUser();

}