import 'dart:async';
import 'dart:convert';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const baseUrl = "http://192.168.100.113:3000/static_pages/index.json";

Future<Post> fetchPost() async {
  final response =
      await http.get(baseUrl);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final String test;
  Post({this.test});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      test: json['test']
    );
  }
}



class NewsFragment extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return new FutureBuilder<Post>(
        future: fetchPost(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Center(
              child: new Text(snapshot.data.test));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

        // By default, show a loading spinner
        return new Center(
          child: CircularProgressIndicator()
          );
  },
);

  }

}