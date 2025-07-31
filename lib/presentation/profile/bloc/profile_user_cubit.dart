import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify/domain/usecases/auth/get_user.dart';
import 'package:flutter_spotify/presentation/profile/bloc/profile_user_state.dart';

import '../../../service_locator.dart';

class ProfileUserCubit extends Cubit<ProfileUserState>{
  ProfileUserCubit(): super(ProfileUserLoading());

  Future<void> loadInfoUser()async {
    var user = await sl<GetCurrentUserUseCase>().call();

    user.fold(
      (l) {
        emit(ProfileUserFailure());
      },
      (userEntity) {
        emit(ProfileUserLoaded(userEntity: userEntity));
      }
    );
  }

}