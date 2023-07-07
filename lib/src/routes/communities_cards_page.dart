import 'package:InstiApp/src/bloc_provider.dart';
import 'package:InstiApp/src/blocs/community_bloc.dart';
import 'package:InstiApp/src/routes/queryaddpage.dart' hide Card;
import 'package:InstiApp/src/utils/customappbar.dart';
import 'package:InstiApp/src/drawer.dart';
import 'package:InstiApp/src/api/model/community.dart';
import 'package:InstiApp/src/routes/communitydetails.dart';
import 'package:InstiApp/src/api/model/body.dart';
import 'package:InstiApp/src/utils/common_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'dart:ui';

import '../utils/share_url_maker.dart';
// import 'package:flutter/rendering.dart';

import 'package:flutter/material.dart';

class Community_cards extends StatefulWidget {
  @override
  _CommunityCardsState createState() => _CommunityCardsState();
}


class _CommunityCardsState extends State<Community_cards> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isPortrait = screenHeight > screenWidth;

    final cardWidth = isPortrait ? screenWidth * 0.958 : screenHeight * 0.6;
    final cardHeight = isPortrait ? screenHeight * 0.1509 : screenWidth * 0.3;

    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      bottomNavigationBar: MyBottomAppBar(
        shape: RoundedNotchedRectangle(),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              tooltip: "Show bottom sheet",
              icon: Icon(
                Icons.menu_outlined,
                semanticLabel: "Show bottom sheet",
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'Communities',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications_none_outlined),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  SizedBox(
                    height: cardHeight,
                    width: cardWidth,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [

                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: -10000000000000, sigmaY: -100000000000000),
                            child: Image.asset(
                              "assets/communities/cards_bg/groups-default-cover-photo-2x.png",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),ClipRRect( // Clip it cleanly.
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX:2, sigmaY: 3),
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                        alignment: Alignment.center,

                      ),),),

                          // Card Content
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Profile Image
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    cardHeight * 0.122,
                                    cardHeight * 0.122,
                                    0,
                                    0),
                                width: cardHeight * 0.427,
                                height: cardHeight * 0.427,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://avatars.githubusercontent.com/u/106103465?s=200&v=4',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 0.033 * cardWidth),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    0, 0.122 * cardHeight, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 0.168 * cardHeight,
                                      child: Text(
                                        "DevCom",
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.129 * cardHeight,
                                      child: Row(
                                        children: [
                                          Text(
                                            "69 Followers",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "  3+ New Posts",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: cardHeight * 0.076),
                                    SizedBox(
                                      height: cardHeight * 0.366,
                                      width: 0.662 * cardWidth,
                                      child: Text(
                                        "Vedant is a Core Team\nMember",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w100,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

