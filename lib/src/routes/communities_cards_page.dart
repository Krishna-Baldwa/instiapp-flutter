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
import 'package:date_format/date_format.dart';
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

    final cardWidth = isPortrait ? screenWidth * 0.958 : screenHeight * 02.4;
    final cardHeight = isPortrait ? screenHeight * 0.1509 : screenWidth *0.3;

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
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'bookmark',
                    child: ListTile(
                      leading: Icon(Icons.bookmark),
                      title: Text('Bookmark'),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'profile',
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Profile'),
                    ),
                  ),
                ];
              },
              onSelected: (String value) {
                if (value == 'bookmark') {
                  // Handle bookmark action
                } else if (value == 'profile') {
                  // Handle profile action
                }
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 232, 236, 242),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                color: Colors.white,
                width: double.infinity,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                      child: Text(
                        'Communities',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications_none_outlined),
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    InkWell(
                      //bug- Inks splashes not visible, might have to use Ink()
                      onTap: () {
                        Navigator.of(context).pushNamed("/idf");
                      },
                      child: SizedBox(
                        height: cardHeight,
                        width: cardWidth,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: -10000000000000,
                                    sigmaY: -100000000000000),
                                child: Image.asset(
                                  "assets/communities/cards_bg/groups-default-cover-photo-2x.png",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              ClipRRect(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 2, sigmaY: 3),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.4),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),

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
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT08CUxFOZpdsCzlMwgTgS_1PkrjrmRqcX5_y7JVHKbcH57Ew_wElDxRamsktqGfKca&usqp=CAU',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 0.168 * cardHeight,
                                          child: Text(
                                            "Insight Discussion Forum",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontFamily: "Roboto"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.129 * cardHeight,
                                          child: Row(
                                            children: [
                                              Text(
                                                "69 Followers ",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                    fontFamily: "Roboto"),
                                              ),
                                              Icon(
                                                //need to make this a bullet point instead of a period
                                                Icons.circle,
                                                color: Colors.white,
                                                size: 3,
                                                // style: TextStyle(
                                                //     fontSize: 12,
                                                //     fontWeight: FontWeight.w500,
                                                //     color: Colors.white,
                                                //     fontFamily:"Roboto"
                                                // ),
                                              ),
                                              Text(
                                                " 3+ New Posts",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                    fontFamily: "Roboto"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: cardHeight * 0.076),
                                        SizedBox(
                                          height: cardHeight * 0.366,
                                          width: 0.6 * cardWidth,
                                          child: Text(
                                            "A platform meant to channel discussions on topics and issues pertinent to the student community of IIT Bombay.",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontFamily: "Roboto"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(cardWidth * 0.83, 0, 0, 0),
                                child: PopupMenuButton<String>(
                                  elevation: 100,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'join',
                                        child: Container(

                                          child: Row(
                                            children: [
                                              Icon(Icons.add),
                                              SizedBox(width: 8.0),
                                              Text('Join'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'share',
                                        child: Container(

                                          child: Row(
                                            children: [
                                              Icon(Icons.share),
                                              SizedBox(width: 8.0),
                                              Text('Share'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'pin',
                                        child: Container(

                                          child: Row(
                                            children: [
                                              Icon(Icons.push_pin),
                                              SizedBox(width: 8.0),
                                              Text('Pin'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ];
                                  },
                                  onSelected: (String value) {
                                    if (value == 'join') {

                                    } else if (value == 'share') {

                                    } else if (value == 'pin') {

                                    }
                                  },
                                  icon: Icon(
                                    Icons.more_vert_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              )


                            ],
                          ),
                        ),
                      ),
                    ),SizedBox(height: screenHeight/100),
                    InkWell(
                      //bug- Inks splashes not visible, might have to use Ink()
                      onTap: () {
                        Navigator.of(context).pushNamed("/idf");
                      },
                      child: SizedBox(
                        height: cardHeight,
                        width: cardWidth,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: -10000000000000,
                                    sigmaY: -100000000000000),
                                child: Image.asset(
                                  "assets/communities/cards_bg/groups-default-cover-photo-2x.png",
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              ClipRRect(
                                child: BackdropFilter(
                                  filter:
                                  ImageFilter.blur(sigmaX: 2, sigmaY: 3),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.4),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),

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
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT08CUxFOZpdsCzlMwgTgS_1PkrjrmRqcX5_y7JVHKbcH57Ew_wElDxRamsktqGfKca&usqp=CAU',
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
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 0.168 * cardHeight,
                                          child: Text(
                                            "Insight Discussion Forum",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontFamily: "Roboto"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.129 * cardHeight,
                                          child: Row(
                                            children: [
                                              Text(
                                                "69 Followers ",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                    fontFamily: "Roboto"),
                                              ),
                                              Icon(
                                                //need to make this a bullet point instead of a period
                                                Icons.circle,
                                                color: Colors.white,
                                                size: 3,
                                                // style: TextStyle(
                                                //     fontSize: 12,
                                                //     fontWeight: FontWeight.w500,
                                                //     color: Colors.white,
                                                //     fontFamily:"Roboto"
                                                // ),
                                              ),
                                              Text(
                                                " 3+ New Posts",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                    fontFamily: "Roboto"),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: cardHeight * 0.076),
                                        SizedBox(
                                          height: cardHeight * 0.366,
                                          width: 0.6 * cardWidth,
                                          child: Text(
                                            "A platform meant to channel discussions on topics and issues pertinent to the student community of IIT Bombay.",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontFamily: "Roboto"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(cardWidth * 0.83, 0, 0, 0),
                                child: PopupMenuButton<String>(
                                  elevation: 100,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  itemBuilder: (BuildContext context) {
                                    return <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'join',
                                        child: Container(

                                          child: Row(
                                            children: [
                                              Icon(Icons.add),
                                              SizedBox(width: 8.0),
                                              Text('Join'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'share',
                                        child: Container(

                                          child: Row(
                                            children: [
                                              Icon(Icons.share),
                                              SizedBox(width: 8.0),
                                              Text('Share'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'pin',
                                        child: Container(

                                          child: Row(
                                            children: [
                                              Icon(Icons.push_pin),
                                              SizedBox(width: 8.0),
                                              Text('Pin'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ];
                                  },
                                  onSelected: (String value) {
                                    if (value == 'join') {

                                    } else if (value == 'share') {

                                    } else if (value == 'pin') {

                                    }
                                  },
                                  icon: Icon(
                                    Icons.more_vert_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
