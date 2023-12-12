part of 'course_bloc.dart';

@freezed
class CourseState with _$CourseState {
  const factory CourseState.initial() = _Initial;
  const factory CourseState.loading() = _Loading;
  const factory CourseState.success(CourseResponseModel data) = _Success;
  const factory CourseState.error(String message) = _Error;
}
