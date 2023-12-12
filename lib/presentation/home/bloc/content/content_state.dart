part of 'content_bloc.dart';

@freezed
class ContentState with _$ContentState {
  const factory ContentState.initial() = _Initial;
  const factory ContentState.loading() = _Loading;
  const factory ContentState.success(ContentResponseModel data) = _Success;
  const factory ContentState.error(String message) = _Error;
}
