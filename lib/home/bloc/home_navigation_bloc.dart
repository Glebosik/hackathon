import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'home_navigation_event.dart';
part 'home_navigation_state.dart';

class HomeNavigationBloc
    extends Bloc<HomeNavigationEvent, HomeNavigationState> {
  final FirestoreRepository firestoreRepository;
  int currentIndex = 0;
  User? user;

  HomeNavigationBloc({required this.firestoreRepository})
      : super(HomeNavigationInitial()) {
    on<HomeNavigationEvent>((event, emit) {});

    on<Init>((event, emit) {
      currentIndex = 0;
      emit(MainPageLoaded());
    });

    on<PageTapped>((event, emit) async {
      currentIndex = event.index;
      if (event.index == 0) {
        emit(MainPageLoaded());
      } else if (event.index == 1) {
        emit(ChatPageLoaded());
      } else if (event.index == 2) {
        emit(ConsultPageLoaded());
      } else if (event.index == 3) {
        emit(ProfilePageLoading());
        try {
          if (user == null) {
            user = await firestoreRepository.currentUserData;
            if (user != null) {
              emit(ProfilePageLoaded(user!));
            } else {
              emit(ProfilePageFail());
            }
          } else {
            emit(ProfilePageLoaded(user!));
          }
        } catch (e) {
          emit(ProfilePageFail());
        }
      }
    });
  }
}
