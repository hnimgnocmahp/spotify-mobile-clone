import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify/common/helpers/is_dark_mode.dart';
import 'package:flutter_spotify/core/configs/theme/app_color.dart';
import 'package:flutter_spotify/domain/entities/song/song.dart';

import '../../../core/configs/constants/app_urls.dart';
import '../../song_player/pages/song_player.dart';
import '../bloc/new_songs_cubit.dart';
import '../bloc/new_songs_state.dart';

class NewSongs extends StatelessWidget{
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewSongsCubit()..getNewSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewSongsCubit, NewSongState>(
          builder: (context, state) {
            if(state is NewSongsLoading){
              return Center(child: CircularProgressIndicator());
            }
            if(state is NewSongsLoaded){
              return _song(state.songs);
            }
            if(state is NewSongsLoadFailure){
              return Center(child: Text('Something went wrong'));
            }
            return Container();
          }
        ),
      ),
    );
  }

  Widget _song(List<SongEntity> songs){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SongPlayerPage(song: songs[index])
                )
              );
            },
            child: SizedBox(
              width: 160,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: NetworkImage(AppUrls().buildCloudinaryCoverUrl(songs[index].cover_id)),
                          fit: BoxFit.cover
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 40,
                          width: 40,
                          transform: Matrix4.translationValues(-10, 10, 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.isDarkMode ? AppColor.darkGrey : Color(0xffE6E6E6),
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: context.isDarkMode ? Color(0xff959595) : Color(0xff555555),
                            size: 25,
                          ),
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      songs[index].title,
                      style: TextStyle(
                        color: context.isDarkMode ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      songs[index].artist,
                      style: TextStyle(
                        color: context.isDarkMode ? Colors.white : Colors.black,
                        fontSize: 14
                      ),
                    ),
                  ),
                ]
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 14,),
        itemCount: songs.length,
      ),
    );
  }
}