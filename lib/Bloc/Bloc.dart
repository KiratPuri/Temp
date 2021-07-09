

import 'package:avtara/Data/Repositories.dart';
import 'package:avtara/Data/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Event.dart';
import 'State.dart';

class CoursesBloc extends Bloc<Event, State> {

  Repository repository;

  CoursesBloc({required this.repository}) : super(InitialState());

  @override
  // TODO: implement initialState
  State get initialState => InitialState();

  @override
  Stream<State> mapEventToState(Event event) async* {
    if (event is FetchEvent) {
      yield LoadingState();
      try {
        List<Courses> courses = await repository.getCourses()!;
        print("in map/////////////////");
        print(courses);
        yield LoadedState(courses: courses);
      } catch (e) {
        yield ErrorState(message: e.toString());
      }
    }
  }

}
