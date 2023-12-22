part of 'quest_list_bloc.dart';

@freezed
class QuestListState with _$QuestListState {
  const factory QuestListState.initial() = _Initial;
  const factory QuestListState.loading() = _Loading;
  const factory QuestListState.success(
    List<Quest> data,
    int index,
    bool isNext,
    ) = _Success;
  const factory QuestListState.error(String message) = _Error;
}
