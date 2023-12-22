import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/responses/exam_response_model.dart';

part 'quest_list_event.dart';
part 'quest_list_state.dart';
part 'quest_list_bloc.freezed.dart';

class QuestListBloc extends Bloc<QuestListEvent, QuestListState> {
  QuestListBloc() : super(const _Initial()) {
    on<_GetQuestList>((event, emit) {
      emit(const _Loading());
      emit(_Success(event.data, 0, event.data.length > 1));
    });

    on<_NextQuest>((event, emit) {
      final currentState = state as _Success;
      emit(_Success(
        currentState.data, 
        currentState.index + 1,
        currentState.data.length > currentState.index + 2));
    });
  }
}
