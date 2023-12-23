part of 'count_score_bloc.dart';

@freezed
class CountScoreState with _$CountScoreState {
  const factory CountScoreState.initial() = _Initial;
  const factory CountScoreState.loading() = _Loading;
  const factory CountScoreState.success(int score) = _Success;
  const factory CountScoreState.error(String message) = _Error;
}
