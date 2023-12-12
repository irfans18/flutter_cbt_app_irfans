// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_cbt_app_irfans/data/datasources/course_remote_datasource.dart';

import '../../../../data/models/responses/course_response_model.dart';

part 'course_bloc.freezed.dart';
part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRemoteDataSource _courseRemoteDataSource;
  CourseBloc(
    this._courseRemoteDataSource,
  ) : super(const _Initial()) {
    on<_GetAllCourse>((event, emit) async {
      emit(const _Loading());
      final response = await _courseRemoteDataSource.getAllCourses();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
