import 'package:flutter_spotify/domain/entities/auth/user.dart';

class ProfileUserState{}

class ProfileUserLoading extends ProfileUserState{}

class ProfileUserLoaded extends ProfileUserState{
  final UserEntity userEntity;
  ProfileUserLoaded({required this.userEntity});
}

class ProfileUserFailure extends ProfileUserState{}