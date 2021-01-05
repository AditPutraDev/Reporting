import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:report_app/models/projects.dart';
import 'package:report_app/models/schedule_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectService {
  static Future<Projects> getProjectsData({String role, int page = 1}) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = pref.get(key) ?? 0;
    String url = role + "/select_schedule?page=$page";
    var client = http.Client();
    var response = await client.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    if (response.statusCode == 200 && response.body != null) {
      var data = json.decode(response.body);
      print(data);
      return Projects.fromJosn(data);
    }
    return null;
  }

  static Future<Projects> getProjectsDataByKeyword(
      {String role, String keyword}) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = pref.get(key) ?? 0;
    String url = role + "/select_schedule?search=$keyword";
    var client = http.Client();
    var response = await client.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    if (response.statusCode == 200 && response.body != null) {
      var data = json.decode(response.body);
      print(data);
      return Projects.fromJosn(data);
    }
    return null;
  }

  static Future<Report> getListProject({String role}) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = pref.get(key) ?? 0;
    String url = role + "/report";
    var client = http.Client();
    var response = await client.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    if (response.statusCode == 200 && response.body != null) {
      var data = json.decode(response.body);
      return Report.fromJson(data);
    }
    return null;
  }

  static Future<List<Schedule>> getProjectsById(
      {String role, String id}) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = pref.get(key) ?? 0;
    String url = role + "/select_schedule/" + id;
    var client = http.Client();
    var response = await client.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    });
    if (response.statusCode == 200 && response.body != null) {
      return scheduleFromJson(response.body);
    }
    return null;
  }

  static Future<bool> postReport({String role, String data}) async {
    final pref = await SharedPreferences.getInstance();
    final key = 'access_token';
    final value = pref.get(key) ?? 0;
    String url = role + "/report";
    var client = http.Client();
    var response = await client.post(url, body: data, encoding: utf8, headers: {
      'content-type': 'application/json',
      'Authorization': 'Bearer $value'
    });
    if (response.statusCode == 200 && response.body != null) {
      return true;
    }
    return false;
  }
}
