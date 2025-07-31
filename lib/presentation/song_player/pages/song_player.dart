import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify/common/helpers/is_dark_mode.dart';
import 'package:flutter_spotify/common/widgets/appbar/app_bar.dart';
import 'package:flutter_spotify/core/configs/constants/app_urls.dart';
import 'package:flutter_spotify/core/configs/theme/app_color.dart';

import '../../../common/widgets/favourite_button/favourite_button.dart';
import '../../../domain/entities/song/song.dart';
import '../bloc/song_player_cubit.dart';
import '../bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget{
  final SongEntity song;
  final bool isRepeat;
  const SongPlayerPage({super.key, required this.song, this.isRepeat = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('Now Playing'),
        action: IconButton(
          onPressed: (){
          },
          icon: Icon(Icons.more_vert_rounded)
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(AppUrls().buildCloudinarySongUrl(song.song_id)),
        child: Column(
          children: [
            _songCover(context),
            SizedBox(height: 20,),
            _songDetail(),
            SizedBox(height: 20,),
            _songPlayer(context),
          ],
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: NetworkImage(AppUrls().buildCloudinaryCoverUrl(song.cover_id)),
            fit: BoxFit.cover
          )
        )
      ),
    );
  }

  Widget _songDetail(){
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 5),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  )
                ),
                Text(
                  song.artist,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey
                  )
                )
              ]
            ),
            FavouriteButton(song: song),
          ],

      ),
    );
  }

  Widget _songPlayer(BuildContext context){
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if(state is SongPlayerLoading){
          return Center(child: CircularProgressIndicator());
        }
        if(state is SongPlayerLoaded){
          return  Column(
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 25),
                  trackHeight: 3,
                ),
                child: Slider(
                  value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                  min: 0.0,
                  max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                  onChanged: (value){
                  },
                  activeColor: context.isDarkMode ? Colors.white : Color(0xff5C5C5C),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(context.read<SongPlayerCubit>().songPosition),
                      style: TextStyle(
                        fontSize: 14
                      ),
                    ),
                    Text(
                      formatDuration(context.read<SongPlayerCubit>().songDuration),
                      style: TextStyle(
                          fontSize: 14
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.repeat_rounded)
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.skip_previous_rounded)
                    ),
                    IconButton(
                      onPressed: (){
                        context.read<SongPlayerCubit>().playOrPauseSong();
                      },
                        highlightColor: Colors.transparent,
                      icon: Icon(

                        color: AppColor.primary,
                        size: 80,
                        context.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause_circle_rounded : Icons.play_circle_fill_rounded
                      )
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.skip_next_rounded)
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.shuffle_rounded)
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        if(state is SongPlayerLoadFailure){
          return Center(child: Text('Something went wrong'));
        }
        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits (int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = duration.inMinutes.remainder(60).toString();
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}