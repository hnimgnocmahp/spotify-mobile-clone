import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify/common/helpers/is_dark_mode.dart';
import 'package:flutter_spotify/common/widgets/appbar/app_bar.dart';
import 'package:flutter_spotify/core/configs/assets/app_images.dart';
import 'package:flutter_spotify/core/configs/theme/app_color.dart';
import 'package:flutter_spotify/presentation/profile/bloc/favourite_songs_cubit.dart';

import '../bloc/favourite_songs_state.dart';
import '../bloc/profile_user_cubit.dart';
import '../bloc/profile_user_state.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     extendBodyBehindAppBar: true,
     appBar: BasicAppBar(
       title: Text('Profile', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
     ),
     body: SingleChildScrollView(
       child: Column(
          children:[
            _infoUser(context),
            _publicPlaylist(),
          ]
       ),
     )

   );
  }

  Widget _infoUser(BuildContext context){
    return BlocProvider(
      create: (context) => ProfileUserCubit()..loadInfoUser(),
      child: BlocBuilder<ProfileUserCubit, ProfileUserState>(
          builder: (context, state) {
            if (state is ProfileUserLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileUserLoaded){
              final halfScreenHeight = MediaQuery.of(context).size.height / 2.1;
              return Stack(
                  children: [
                    Container(
                      height: halfScreenHeight,
                      decoration: BoxDecoration(
                          color: context.isDarkMode ? AppColor.darkGrey : AppColor.grey,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          )
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          SizedBox(height: halfScreenHeight* 0.3),
                          Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: context.isDarkMode ? AppColor.grey : AppColor.darkGrey,
                                      width: 2
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.appleIcon),
                                    fit: BoxFit.cover,
                                  )
                              )
                          ),
                          SizedBox(height: 15,),
                          Text(
                            state.userEntity.email.toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: context.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            state.userEntity.fullName.toString(),
                            style: TextStyle(
                                fontSize: 20,
                                color: context.isDarkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: context.isDarkMode ? Colors.white : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Following',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: context.isDarkMode ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ]
                              ),
                              Column(
                                  children: [
                                    Text(
                                      '0',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: context.isDarkMode ? Colors.white : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Followers',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: context.isDarkMode ? Colors.white : Colors.black,
                                      ),
                                    ),
                                  ]
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ]
              );
            }
            if (state is ProfileUserFailure){
              return Text('Something was wrong');
            }
            return Container();
          }
      ),
    );
  }

  Widget _publicPlaylist(){
    return BlocProvider(
      create: (context) => FavouriteSongsCubit()..loadFavouriteSongs(),
      child: BlocBuilder<FavouriteSongsCubit, FavouriteSongsState>(
        builder: (context, state) {
          if (state is FavouriteSongsLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FavouriteSongsLoaded){
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index){
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode ? AppColor.darkGrey : Color(0xffE6E6E6),
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: context.isDarkMode ? Color(0xff959595) : Color(0xff555555),
                      size: 25,
                    ),
                  ),
                  title: Text(
                    state.songEntities[index].title,
                    style: TextStyle(
                      color: context.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    state.songEntities[index].artist,
                    style: TextStyle(
                        color: context.isDarkMode ? Colors.white : Colors.black,
                        fontSize: 14
                    ),
                  ),
                  trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.songEntities[index].duration.toStringAsFixed(2).replaceAll(".", ":").toString(),
                          style: TextStyle(
                              color: context.isDarkMode ? Colors.white : Colors.black,
                              fontSize: 15
                          ),
                        ),
                        SizedBox(width: 30,),
                      ]
                  ),
                );
              },
              itemCount: state.songEntities.length,
              itemBuilder: (context, index) => const SizedBox(height: 10,),
            );
          }
          if (state is FavouriteSongsFailure){
            return Text('Something was wrong');
          }
          return Container();
        }
      ),
    );
  }
}