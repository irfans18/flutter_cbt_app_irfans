part of 'quest_list_bloc.dart';

@freezed
class QuestListEvent with _$QuestListEvent {
  const factory QuestListEvent.started() = _Started;
  const factory QuestListEvent.getQuestList(List<Quest> data) = _GetQuestList;
  // next quest
  const factory QuestListEvent.nextQuest() = _NextQuest;
}