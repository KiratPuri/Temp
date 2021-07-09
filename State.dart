import 'package:avtara/Data/models.dart';
import 'package:equatable/equatable.dart';

abstract class State extends Equatable {}

class InitialState extends State {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadingState extends State {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadedState extends State {

  List<Courses> courses;

  LoadedState({required this.courses});

  @override
  // TODO: implement props
  List<Object> get props => [courses];
}

class ErrorState extends State {

  String message;

  ErrorState({required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}