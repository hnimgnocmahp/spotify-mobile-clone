import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spotify/common/helpers/is_dark_mode.dart';
import 'package:flutter_spotify/common/widgets/appbar/app_bar.dart';
import 'package:flutter_spotify/core/configs/assets/app_images.dart';
import 'package:flutter_spotify/core/configs/assets/app_vectors.dart';
import 'package:flutter_spotify/core/configs/theme/app_color.dart';
import 'package:flutter_spotify/presentation/root/widgets/new_song.dart';
import 'package:flutter_spotify/presentation/root/widgets/play_list.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _homeTopCard(),
            _tab(),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                children: [
                  const NewSongs(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
            SizedBox(height: 40,),
            const Playlist(),
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard(){
    return Center(
      child: SizedBox(
        height: 144,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(AppImages.homeTopCard),
            ),

            Padding(
              padding: EdgeInsets.only(right: 60),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(AppImages.homeArtist),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _tab(){
    return TabBar(
      controller: _tabController,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      indicatorColor: AppColor.primary,
      padding: EdgeInsets.symmetric(vertical: 20),
      labelPadding: EdgeInsets.zero,
      tabs: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Text('News', textAlign: TextAlign.center),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Text('Videos', textAlign: TextAlign.center),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Text('Artists', textAlign: TextAlign.center),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Text('Podcasts', textAlign: TextAlign.center),
        ),
      ],
    );
  }
}