/*
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class CourseBloc {
  StreamController<List<Course>> _allCourses = StreamController<List<Course>>();
  Stream<List<Course>> get getCourses => _allCourses.stream;
  StreamSink<List<Course>> get setCourses => _allCourses.sink;

  CourseBloc(){
    this._allCourses;
  }

  fetchAllCourses(){
    final queryParameters = {
      'page': "1",
      'limit': "5",
    };
    Firebase.initializeApp().whenComplete(() async {
      print("///////////////////////Started");
      final tokenResult = await FirebaseAuth.instance.currentUser!;
      final idToken = await tokenResult.getIdToken();
      http.get(
          Uri.http("192.168.1.3:4000", "/courses", queryParameters),
          headers: {"Authorization" : "Bearer ${idToken}"}
      ).then((response) {
        print(response.statusCode);
        print(response.body);
        print("///////////////////////End");
      }
      );
    }
    );
  }

}
*/
