import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttervideostreaming/commonwidgets/eventlistwidget.dart';
import 'package:fluttervideostreaming/models/postmodels.dart';
import 'package:google_fonts/google_fonts.dart';

class EvenListWidget extends StatelessWidget {
  final Future<PostsModel> eventFuture;
  final String title;
  final String nextStartingEvent;

  EvenListWidget({@required this.title, @required this.eventFuture,this.nextStartingEvent});
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: GoogleFonts.titilliumWeb(textStyle: TextStyle(color: Colors.white,fontSize: 26)),
          ),
        ),
        Container(
          height: 250,
          child: FutureBuilder<PostsModel>(
            future: eventFuture,
            builder: (BuildContext context, AsyncSnapshot<PostsModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if(snapshot.data.data.events.isEmpty){
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            'No $title Event Available Now',
                            style: GoogleFonts.oswald(textStyle: TextStyle(color: Colors.white,fontSize: 21))
                        ),
                        SizedBox(height: 10,),
                        Text(
                            'Next: The Skating Lesson: Episode 56',
                            style: GoogleFonts.oswald(textStyle: TextStyle(color: Colors.green,fontSize: 26))
                        ),
                        EventCountDown(),
                      ],
                    ),
                  );
                }
                return EventListView(eventModel: snapshot.data,);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

class EventCountDown extends StatefulWidget {
  @override
  _EventCountDownState createState() => _EventCountDownState();
}

class _EventCountDownState extends State<EventCountDown> {



  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                  '0',
                  style: GoogleFonts.rajdhani(textStyle: TextStyle(color: Colors.white,fontSize: 26))
              ),
              Text(
                  'Days',
                  style: GoogleFonts.raleway(textStyle: TextStyle(color: Colors.white,fontSize: 14))
              ),
            ],
          ),
          SizedBox(width: 5,),
          Column(
            children: <Widget>[
              Text(
                  '21',
                  style: GoogleFonts.rajdhani(textStyle: TextStyle(color: Colors.white,fontSize: 26))
              ),
              Text(
                  'Hours',
                  style: GoogleFonts.raleway(textStyle: TextStyle(color: Colors.white,fontSize: 14))
              ),
            ],
          ),
          SizedBox(width: 5,),
          Column(
            children: <Widget>[
              Text(
                  '30',
                  style: GoogleFonts.rajdhani(textStyle: TextStyle(color: Colors.white,fontSize: 26))
              ),
              Text(
                  'Minutes',
                  style: GoogleFonts.raleway(textStyle: TextStyle(color: Colors.white,fontSize: 14))
              ),
            ],
          ),
        ],
      ),
    );
  }
}
