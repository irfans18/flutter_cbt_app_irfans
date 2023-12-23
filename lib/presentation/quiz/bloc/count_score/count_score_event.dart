part of 'count_score_bloc.dart';

@freezed
class CountScoreEvent with _$CountScoreEvent {
  const factory CountScoreEvent.started() = _Started;
  const factory CountScoreEvent.countScore(String category) = _CountScore;
}