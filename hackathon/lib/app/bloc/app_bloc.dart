import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(
      {required AuthenticationRepository authenticationRepository,
      required bool? status})
      : _authenticationRepository = authenticationRepository,
        super(
          status == null
              ? const AppState.unauthenticated()
              : status
                  ? AppState.authenticatedInspector(
                      authenticationRepository.currentUser)
                  : AppState.authenticatedUser(
                      authenticationRepository.currentUser),
        ) {
    on<_AppUserChanged>((event, emit) async {
      final user = event.user;
      if (user.isNotEmpty) {
        if (_emails.contains(user.email)) {
          emit(AppState.authenticatedInspector(user));
        } else {
          emit(AppState.authenticatedUser(user));
        }
        /*final doc =
            await FirebaseFirestore.instance.doc('inspectors/${user.id}').get();
        if (doc.exists) {
          emit(AppState.authenticatedInspector(user));
        } else {
          emit(AppState.authenticatedUser(user));
        }*/
      } else {
        emit(const AppState.unauthenticated());
      }
    });
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(_AppUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;
  static const List<String> _emails = [
    'donm@gmail.com',
    'dzhkh@gmail.com',
    'mosgostroinadzor@gmail.com',
    'moscomstroiinvest@gmail.com',
    'mosgornasledie@gmail.com',
    'mospriroda@gmail.com',
    'depr@gmail.com',
    'depcult@gmail.com',
    'mzhi@gmail.com',
    'gochsipb@gmail.com',
    'dtirdt@gmail.com',
    'madi@gmail.com',
    'oati@gmail.com',
    'dtszn@gmail.com',
    'dtiu@gmail.com',
    'moscomvet@gmail.com',
    'dzn@gmail.com',
    'gin@gmail.com',
    'glavarchive@gmail.com',
    'test2@test.ru',
  ];
  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
