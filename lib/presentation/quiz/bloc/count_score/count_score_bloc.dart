// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_cbt_app_irfans/data/datasources/exam_remote_datasource.dart';

part 'count_score_bloc.freezed.dart';
part 'count_score_event.dart';
part 'count_score_state.dart';

class CountScoreBloc extends Bloc<CountScoreEvent, CountScoreState> {
  final ExamRemoteDataSource _examRemoteDataSource;
  CountScoreBloc(
    this._examRemoteDataSource,
  ) : super(const _Initial()) {
    on<_CountScore>((event, emit) async {
      emit(const _Loading());
      final response = await _examRemoteDataSource.countScore(event.category);
      // response.fold((l) => emit(_Error(l)), (r) => emit(_Success(r)));
    });
  }
}
