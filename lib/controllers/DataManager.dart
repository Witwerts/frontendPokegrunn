import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DataManager {
  static Future<Response?> postResult(String url, [Map<String, dynamic> body = const {}, int timeout = 5000]) async {
    var url = Uri.parse("");
    var headers = {"Content-Type": "application/json; charset=UTF-8"};

    Response? response = null;

    try {
      print("post data: $url");
      response = await http.post(url,
        headers: headers,
        body: jsonEncode(body)
      ).timeout(Duration(milliseconds: timeout));
    }
    catch(_){}

    return response;
  }

  static Future<Map<String, dynamic>?> postData(String page, [Map<String, dynamic> body = const {}, bool useAuth = true, int timeout = 5000]) async {
    Response? response = await postResult(page, body, timeout);

    return convertData(response) as Map<String, dynamic>?;
  }

  static Future<Response?> getResponse(String url, [int timeout = 5000]) async {
    var uri = Uri.parse(url);
    var headers = {"Content-Type": "application/json; charset=UTF-8"};

    Response? response = null;

    try {
      print("get data: $url");
      response = await http.get(uri, headers: headers).timeout(Duration(milliseconds: timeout));
    }
    catch(_){
      print("error??");
    }

    return response;
  }

  static Future<Map<String, dynamic>?> getData(String url, [int timeout = 5000]) async {
    Response? response = await getResponse(url, timeout);

    return convertData(response) as Map<String, dynamic>?;
  }

  static dynamic? convertData(Response? response){
    if(response != null && response.body.isNotEmpty){
      return json.decode(response.body);
    }

    return null;
  }

  static Future<String?> getResource(String path) async {
    try {
      return await rootBundle.loadString(path);
    }
    catch(_){
      return null;
    }
  }
}