import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/auth_remote_datasources.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(_Initial()) {
    on<LogoutEvent>((event, emit) async{
      emit(const _Loading());
      final response = await AuthRemoteDataSource().logout();
      response.fold(
        (l) => emit(const _Error()), 
        (r) => emit(const _Success())
      );
    });
  }
}
