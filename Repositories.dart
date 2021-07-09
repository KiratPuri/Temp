import 'models.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';

abstract class Repository {
  Future<List<Courses>>? getCourses();
}

class RepositoryImpl implements Repository {

  @override
  Future<List<Courses>>? getCourses() async {
    final queryParameters = {
      'page': "1",
      'limit': "5",
    };
    Firebase.initializeApp().whenComplete(() async {
      final tokenResult = await FirebaseAuth.instance.currentUser!;
      final idToken = await tokenResult.getIdToken();
      http.get(
          Uri.http("192.168.1.3:4000", "/courses", queryParameters),
          headers: {"Authorization" : "Bearer ${idToken}"}
      ).then((response) {
        print(response.body);
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          List<Courses> courses = Autogenerated.fromJson(data).courses!;
          print(courses[0]);
          return courses;
        } else {
          throw Exception();
        }
      }
      );
    }
    );
    throw Exception("All Good, Chill !!!");
  }

}