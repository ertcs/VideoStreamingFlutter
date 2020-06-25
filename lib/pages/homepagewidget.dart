
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttervideostreaming/commonwidgets/bannerwidget.dart';
import 'package:fluttervideostreaming/commonwidgets/commonsfunctions.dart';
import 'package:fluttervideostreaming/commonwidgets/eventlistcolum.dart';

import 'package:fluttervideostreaming/databaseservice/dbservice.dart';
import 'package:fluttervideostreaming/models/postmodels.dart';

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  Future<PostsModel> pastEvents;
  Future<PostsModel> liveEvents;
  Future<PostsModel> upComingEvents;

  @override
  void initState() {
    super.initState();
    liveEvents = RequestDbService().eventPosts(livePageUrl);
    upComingEvents = RequestDbService().eventPosts(upcomingPageUrl);
    pastEvents = RequestDbService().eventPosts(pastPageUrl);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(4281019179),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Center(
                child: Text('FS'),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BannerWidget(),
            SizedBox(
              height: 10,
            ),
            EvenListWidget(title: 'Live',eventFuture: liveEvents,),
            EvenListWidget(title: 'Up Coming',eventFuture: upComingEvents,),
            EvenListWidget(title: 'Past',eventFuture: pastEvents,),

          ],
        ),
      ),
    );
  }
}



