
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttervideostreaming/commonwidgets/commonsfunctions.dart';
import 'package:fluttervideostreaming/databaseservice/dbservice.dart';
import 'package:fluttervideostreaming/models/postitemmodel.dart';
import 'package:fluttervideostreaming/models/postmodels.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class EventDetailPage extends StatefulWidget {
  final Events event;
  final int index;
  EventDetailPage({@required this.event, this.index});
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  VideoPlayerController _controller;
  ChewieController _chewieController;
  Future<PostItemModel> itemFuture;


  @override
  void initState() {
    super.initState();
    itemFuture = RequestDbService().itemPost(widget.event.id);


  }

  initVideoPlayer(PostItemModel itemModel){
    _controller = VideoPlayerController.network(itemModel.data.detail.trailer);
    _chewieController = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: false,
        autoInitialize: true,
        showControlsOnInitialize: false,
        placeholder: Container(
          child: CachedNetworkImage(
            imageUrl: itemModel.data.detail.poster,
            fit: BoxFit.fill,
          ),
        )
    );
  }


  @override
  void dispose() {
    _chewieController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(4281019179),
      appBar: AppBar(
        backgroundColor: Color(4281019179),
        elevation: 0,
        leading: BackButton(
          color: Colors.white,
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
      body: FutureBuilder<PostItemModel>(
        future: itemFuture,
        builder: (BuildContext context, AsyncSnapshot<PostItemModel> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            initVideoPlayer(snapshot.data);
            PostItemModel postItemModel = snapshot.data;
            bool isLabelFull = postItemModel.data.detail.label.length>3;
            List<String> contentList = getHTMLDocument(postItemModel.data.detail.description);
            String eventTitle = widget.event.title.length>30?'${widget.event.title.substring(0,30)}....':widget.event.title;
            return Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                Chewie(controller: _chewieController,),
                    SizedBox(height: 10,),
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8,bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.local_movies,color: Colors.green,size: 35,),
                                SizedBox(width: 10,),
                                Text(
                                    eventTitle,
                                    style: GoogleFonts.rajdhani(textStyle: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w500)),
                                ),
                                Spacer(),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(6)),
                                  child: Center(
                                      child: Text(
                                        postItemModel.data.detail.label,
                                        style: TextStyle(fontSize: isLabelFull?10:16, color: Colors.white,fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(6)),
                                  child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            getEventDateDay(widget.event.startAt),
                                            style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            getEventMonth(widget.event.startAt),
                                            style: TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(getEventDay(widget.event.startAt),
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '${getEventTime(widget.event.startAt)} - ${getEventTime(widget.event.endAt)}',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(Icons.share,color: Colors.white,),
                                SizedBox(width: 5,)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15,left: 8,bottom: 0),
                            child:Text(
                              'appearing live'.toUpperCase(),
                              style: TextStyle(color: Colors.white,fontWeight:FontWeight.w500,fontSize: 18),
                            ),
                          ),
                          Container(
                            height: 160,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: postItemModel.data.roles.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 120,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                              postItemModel.data.roles[index].avatar,

                                            ),
                                            fit: BoxFit.fill
                                          )
                                        ),
                                      ),
                                      SizedBox(height: 2,),
                                      Center(
                                        child: Text(
                                          postItemModel.data.roles[index].displayName,
                                          style: GoogleFonts.oswald(textStyle: TextStyle(color: Colors.white,fontSize: 16)),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Live Chat:',
                                  style: GoogleFonts.rajdhani(textStyle: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(height: 2,),
                                Wrap(
                                  children: <Widget>[
                                    Text('${contentList[1]}',textAlign: TextAlign.justify,
                                      style: GoogleFonts.rajdhani(textStyle: TextStyle(color: Colors.white,fontSize: 18)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text('Instruction:',
                                    style: GoogleFonts.rajdhani(textStyle: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(height: 2,),
                                Wrap(
                                  children: <Widget>[
                                    Text('${contentList[0]}',textAlign: TextAlign.justify,
                                      style: GoogleFonts.rajdhani(textStyle: TextStyle(color: Colors.white,fontSize: 18)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text('Synopsis:',
                                  style: GoogleFonts.rajdhani(textStyle: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(height: 2,),
                                Wrap(
                                  children: <Widget>[
                                    Text('${contentList[2].replaceAll('Synopsis:','').trim()}',textAlign: TextAlign.justify,
                                      style: GoogleFonts.rajdhani(textStyle: TextStyle(color: Colors.white,fontSize: 18)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 100,)
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Ticket: \$${postItemModel.data.ticket.price}',
                              style: GoogleFonts.rajdhani(textStyle: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w500)),
                            ),
                            Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Center(
                                child: Text('BUY',
                                  style: TextStyle(fontSize: 18,color: Colors.green),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      ),

                    ),
                  ),
                )
              ],
            );
          }
          return Container(height: 2,child: LinearProgressIndicator(),);
        },

      ),

    );
  }
}
