import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/auth/create_user_req.dart';
import '../../models/auth/signing_user_reg.dart';

abstract class AuthFirebaseService {
  Future<Either<String, String>> signup(CreateUserReg createUserReg);
  Future<Either<String, String>> signin(SigningUserReg signingUserReg);
  // Future<void> signOut();
  // Future<void> resetPassword();
}

class AuthFirebaseServiceImpl implements AuthFirebaseService{
  @override
  Future<Either<String, String>> signin(SigningUserReg signingUserReg) async{
    if (signingUserReg.email.isEmpty || signingUserReg.password.isEmpty) {
      return Left('Email hoặc mật khẩu không được để trống');
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signingUserReg.email, password: signingUserReg.password
      );
      return Right('Signing was Successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'Not user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either<String, String>> signup(CreateUserReg createUserReg) async{
    try {
      if (createUserReg.fullName.isEmpty ||
          createUserReg.email.isEmpty ||
          createUserReg.password.isEmpty ||
          createUserReg.confirmPassword.isEmpty) {
        return Left('Fields cannot be empty');
      }
      if (createUserReg.password != createUserReg.confirmPassword) {
        return Left('Passwords do not match.');
      }
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReg.email, password: createUserReg.password
      );
      await data.user?.updateDisplayName(createUserReg.fullName);

      try {
        await FirebaseFirestore.instance.collection('Users').doc(data.user?.uid)
            .set({
                'name': createUserReg.fullName,
                'email': data.user?.email,
                'uid': data.user!.uid,
                'createdAt': DateTime.now()
            });
      } catch (e) {
        print(e);
      }

      return const Right('Signup was Successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'The email provided is invalid.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else {
        message = 'Something went wrong';
      }
      return Left(message);
    }
  }

}