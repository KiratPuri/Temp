import 'package:avtara/Bloc/Bloc.dart';
import 'package:avtara/Data/Repositories.dart';
import 'package:avtara/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'BottomNav.dart';
import 'Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (BuildContext context) {CoursesBloc(repository: RepositoryImpl());},
      ),
    );
  }
}
