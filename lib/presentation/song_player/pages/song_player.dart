import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spotify/common/widgets/appbar/app_bar.dart';
import 'package:flutter_spotify/core/configs/constants/app_urls.dart';
import 'package:flutter_spotify/domain/entities/song/song.dart';

class SongPlayerPage extends StatelessWidget{
  final SongEntity song;
  const SongPlayerPage({super.key, required this.song});

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _songCover(context),
            SizedBox(height: 20,),
            _songDetail(),
          ],
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: NetworkImage(AppUrls().buildCloudinaryUrl(song.cover_id)),
          fit: BoxFit.cover
        )
      )
    );
  }

  Widget _songDetail(){
    return Row(
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
        IconButton(
          onPressed: (){},
          icon: Icon(Icons.favorite_border_rounded)
        )
      ],
    );
  }
}