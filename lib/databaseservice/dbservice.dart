
import 'package:fluttervideostreaming/models/postitemmodel.dart';
import 'package:fluttervideostreaming/models/postmodels.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

abstract class DbService{
  Future<PostsModel> eventPosts(String url);
  Future<PostItemModel> itemPost(String id);
}

class RequestDbService extends DbService{


  static String getPostUrl(String id){
    return ;

  }

  @override
  Future<PostItemModel> itemPost(String id)async{
    String url = getPostUrl(id);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return PostItemModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }

  @override
  Future<PostsModel> eventPosts(String url)async{
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return PostsModel.fromJson(jsonResponse);
    } else {
      return null;
    }
  }

}