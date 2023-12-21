// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_cbt_app_irfans/data/datasources/exam_remote_datasource.dart';

import '../../../../data/models/responses/exam_response_model.dart';

part 'exam_by_category_bloc.freezed.dart';
part 'exam_by_category_event.dart';
part 'exam_by_category_state.dart';

class ExamByCategoryBloc
    extends Bloc<ExamByCategoryEvent, ExamByCategoryState> {
  final ExamRemoteDataSource _examRemoteDataSource;
  ExamByCategoryBloc(
    this._examRemoteDataSource,
  ) : super(const _Initial()) {
    on<_GetExamByCategory>((event, emit) async {
      emit(const _Loading());
      final response =
          await _examRemoteDataSource.getExamByCategory(event.category);
      response.fold(
        (l) => emit(_Error(l)),
        (r) {
          if (r.data.isEmpty) {
            emit(const _NotFound());
          } else {
            emit(_Success(r));
          }
        },
      );
    });
  }
}
