import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify/common/helpers/is_dark_mode.dart';

import '../../../common/widgets/favourite_button/favourite_button.dart';
import '../../../core/configs/theme/app_color.dart';
import '../../../domain/entities/song/song.dart';
import '../../song_player/pages/song_player.dart';
import '../bloc/play_list_cubit.dart';
import '../bloc/play_list_state.dart';

class Playlist extends StatelessWidget{
  const Playlist({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => PlaylistCubit()..getNewSongs(),
        child: BlocBuilder<PlaylistCubit, PlaylistState>(
          builder: (context, state) {
            if(state is PlaylistLoading){
              return Center(child: CircularProgressIndicator());
            }
            if(state is PlaylistLoaded){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.isDarkMode ? Colors.white : Colors.black,
                            fontSize: 20
                          ),
                          'Playlist'
                        ),
                       Text(
                        'See more',
                        style: TextStyle(
                          fontSize: 12,
                          color: context.isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500
                        ),
                       ),
                      ],
                    ),
                  ),
                  _song(state.songs),
                ],
              );
            }
            if(state is PlaylistLoadFailure) {
              return Center(child: Text('Something went wrong'));
            }
            return Container();
          }
        )
    );
  }

  Widget _song(List<SongEntity> songs){
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index){
        return ListTile(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SongPlayerPage(song: songs[index],)
                )
            );
          },
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
            songs[index].title,
            style: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            songs[index].artist,
            style: TextStyle(
              color: context.isDarkMode ? Colors.white : Colors.black,
              fontSize: 14
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                songs[index].duration.toStringAsFixed(2).replaceAll(".", ":").toString(),
                style: TextStyle(
                  color: context.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 15
                ),
              ),
              SizedBox(width: 30,),
              FavouriteButton(song: songs[index]),
           ]
          ),
        );

      },
      separatorBuilder: (context, index) => const SizedBox(height: 10,),
      itemCount: songs.length
    );
  }
}