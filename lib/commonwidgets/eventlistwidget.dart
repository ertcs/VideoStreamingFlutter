

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttervideostreaming/commonwidgets/commonsfunctions.dart';
import 'package:fluttervideostreaming/models/postmodels.dart';
import 'package:fluttervideostreaming/pages/eventdetailpage.dart';
import 'package:google_fonts/google_fonts.dart';

class EventListView extends StatelessWidget {
  final PostsModel eventModel;
  EventListView({@required this.eventModel});



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: eventModel.data.events.length,
      itemBuilder: (context, index) {
        Events event = eventModel.data.events[index];
        String eventTitle = event.title.length>30?'${event.title.substring(0,30)}....':event.title;
        return GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EventDetailPage(event: event,index: index,)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 250,
              color: Colors.black,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Stack(
                children: <Widget>[
                  ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.xor,
                    child: CachedNetworkImage(
                      imageUrl: event.thumbnail,
                      fit: BoxFit.fill,
                      height: 250,
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    left: 5,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                  child: Text(
                                    getEventDate(event.startAt),
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Wrap(
                              children: <Widget>[
                                Text(
                                    eventTitle,
                                    style: GoogleFonts.rajdhani(textStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500))
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          height: 60,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: event.appearingPeople.length,
                            itemBuilder: (context, index) {
                              bool isImageAvailable = event.appearingPeople[index].avatar.length>10;
                              return Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Column(
                                    children: <Widget>[
                                      isImageAvailable?CircleAvatar(
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: event.appearingPeople[index].avatar,
                                          ),
                                        ),
                                      ):CircleAvatar(
                                        backgroundColor: Colors.blueGrey,
                                        child: Center(
                                          child: Text('${event.appearingPeople[index].firstName.substring(0,1).toUpperCase()}',
                                              style: GoogleFonts.raleway(textStyle: TextStyle(color: Colors.white))
                                          ),
                                        ),
                                      ),
                                      Text(event.appearingPeople[index].firstName,style: GoogleFonts.oswald(textStyle: TextStyle(color: Colors.white,fontSize: 10)) ,)
                                    ],
                                  )
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}