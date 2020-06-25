
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttervideostreaming/commonwidgets/commonsfunctions.dart';
import 'package:google_fonts/google_fonts.dart';


class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height * 0.90));
            },
            blendMode: BlendMode.xor,
            child: Padding(
              padding: const EdgeInsets.only(left: 13, right:0),
              child: CachedNetworkImage(
                imageUrl: imagesList[0],
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                Text(
                  '04 Aug 2020'.toUpperCase(),
                  style: GoogleFonts.oswald(textStyle: TextStyle(color: Colors.white)),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Coming soon'.toUpperCase(),
                  style: GoogleFonts.oswald(textStyle: TextStyle(color: Colors.white,fontSize: 26)),
                ),
                SizedBox(
                  height: 5,
                ),
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.white)),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Text(
                      'GET TICKET',
                      style: GoogleFonts.raleway(textStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
