
import 'package:flutter/material.dart';


class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20,left: 20,top: 10,bottom: 10),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: hexToColor('#18181c'),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search,color: Colors.white54,),
            ),
            SizedBox(width: 5,),
            Text('Search',style: TextStyle(color: Colors.white54),)
          ],
        ),
      ),

    );
  }
}
