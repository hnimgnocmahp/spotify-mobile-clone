import 'package:flutter_spotify/domain/entities/auth/user.dart';

class UserModel {
  String ? fullName;
  String ? email;
  String ? imgUrl;

  UserModel({
    required this.fullName,
    required this.email,
    required this.imgUrl,
  });

  UserModel.fromJson(Map<String, dynamic> json){
    fullName = json['name'];
    email = json['email'];
  }
}

extension UserModelExtension on UserModel{
  UserEntity toEntity(){
    return UserEntity(
      fullName: fullName,
      email: email,
      imgUrl: imgUrl,
    );
  }
}