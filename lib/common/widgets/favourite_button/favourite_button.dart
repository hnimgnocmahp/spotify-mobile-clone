import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify/common/helpers/is_dark_mode.dart';

import '../../../core/configs/theme/app_color.dart';
import '../../../domain/entities/song/song.dart';
import '../../bloc/favourite_button/favourite_button_cubit.dart';
import '../../bloc/favourite_button/favourite_button_state.dart';

class FavouriteButton extends StatelessWidget{
  const FavouriteButton({super.key, required this.song});
  final SongEntity song;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouriteButtonCubit(),
      child: BlocBuilder<FavouriteButtonCubit, FavouriteButtonState>(
        builder: (context, state) {
          if (state is FavouriteButtonInitial) {
            return IconButton(
              onPressed: (){
                context.read<FavouriteButtonCubit>().favouriteButtonUpdated(song.songId);
              },
              icon: Icon(
                song.isFavourite  ? Icons.favorite : Icons.favorite_border_rounded,
                color: context.isDarkMode ? AppColor.darkGrey : Color(0xffB4B4B4),
                size: 30,
              ),
            );
          }

          if (state is FavouriteButtonUpdated) {
            return IconButton(
              onPressed: (){
                context.read<FavouriteButtonCubit>().favouriteButtonUpdated(song.songId);
              },
              icon: Icon(
                state.isFavourite  ? Icons.favorite : Icons.favorite_border_rounded,
                color: context.isDarkMode ? AppColor.darkGrey : Color(0xffB4B4B4),
                size: 30,
              ),
            );
          }

          return Container();
        }
      ),
    );
  }
  
}