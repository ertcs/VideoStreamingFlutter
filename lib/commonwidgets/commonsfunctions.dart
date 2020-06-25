
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

String livePageUrl ='';
String pastPageUrl ='';
String upcomingPageUrl ='';
String appIntoUrl ='';

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

enum tabEnum{
  PAST,
  LIVE,
  NEXT,
}

List<String> imagesList = [

];

String getEventDate(String eventDate){
  DateTime dateTime = DateTime.parse(eventDate);
  var newFormat = DateFormat("MMM");
  String updatedDt = newFormat.format(dateTime);
  return '${dateTime.day}\n$updatedDt';
}

String getEventMonth(String eventDate){
  DateTime dateTime = DateTime.parse(eventDate);
  var newFormat = DateFormat("MMM");
  return newFormat.format(dateTime);
}

String getEventDateDay(String eventDate){
  DateTime dateTime = DateTime.parse(eventDate);
  return dateTime.day.toString();
}

String getEventDay(String eventDate){
  DateTime dateTime = DateTime.parse(eventDate);
  var newFormat = DateFormat("EEEE");
  return newFormat.format(dateTime);

}

String getEventTime(String eventDate){
  DateTime dateTime = DateTime.parse(eventDate);
  var newFormat = DateFormat('h:mm a');
  return newFormat.format(dateTime);

}

List<String> getHTMLDocument (String htmlString){
  List<String> contentList =[];
  Document document =parse(htmlString);
  document.body.children.forEach((element) {contentList.add(element.text);});
  return contentList;
}