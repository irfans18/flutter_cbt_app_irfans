// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_cbt_app_irfans/data/datasources/exam_remote_datasource.dart';
import 'package:flutter_cbt_app_irfans/data/models/responses/exam_response_model.dart';

part 'create_exam_bloc.freezed.dart';
part 'create_exam_event.dart';
part 'create_exam_state.dart';

class CreateExamBloc extends Bloc<CreateExamEvent, CreateExamState> {
  final ExamRemoteDataSource _examRemoteDataSource;
  CreateExamBloc(
    this._examRemoteDataSource,
  ) : super(const _Initial()) {
    on<CreateExamEvent>((event, emit) async {
      emit(const _Loading());
      final response = await _examRemoteDataSource.createExam();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
