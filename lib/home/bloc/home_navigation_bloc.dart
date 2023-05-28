import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firestore_repository/firestore_repository.dart';

part 'home_navigation_event.dart';
part 'home_navigation_state.dart';

class HomeNavigationBloc
    extends Bloc<HomeNavigationEvent, HomeNavigationState> {
  final FirestoreRepository firestoreRepository;
  int currentIndex = 0;
  User? user;
  List<Application> applications = [];

  HomeNavigationBloc({required this.firestoreRepository})
      : super(HomeNavigationInitial()) {
    on<HomeNavigationEvent>((event, emit) {});

    on<UpdateApplications>((event, emit) async {
      emit(ConsultPageLoading());
      try {
        if (auth.FirebaseAuth.instance.currentUser!.email != 'test1@test.ru') {
          applications = await firestoreRepository.getUserApplications();
        } else {
          applications = testApplications;
        }
        emit(ConsultPageLoaded(applications));
      } catch (e) {
        emit(ConsultPageFailed());
      }
    });

    on<PageTapped>((event, emit) async {
      currentIndex = event.index;
      if (event.index == 0) {
        emit(MainPageLoaded());
      } else if (event.index == 1) {
        emit(ChatPageLoaded());
      } else if (event.index == 2) {
        emit(ConsultPageLoading());
        try {
          if (auth.FirebaseAuth.instance.currentUser!.email !=
              'test1@test.ru') {
            if (applications.isEmpty) {
              applications = await firestoreRepository.getUserApplications();
            }
          } else {
            applications = testApplications;
          }
          emit(ConsultPageLoaded(applications));
        } catch (e) {
          emit(ConsultPageFailed());
        }
      } else if (event.index == 3) {
        emit(ProfilePageLoading());
        try {
          if (user == null) {
            user = await firestoreRepository.currentUserData;
            if (user != null) {
              emit(ProfilePageLoaded(user!));
            } else {
              emit(ProfilePageFailed());
            }
          } else {
            emit(ProfilePageLoaded(user!));
          }
        } catch (e) {
          emit(ProfilePageFailed());
        }
      }
    });
  }

  final List<Application> testApplications = [
    Application(
        dateStart: DateTime.now(),
        dateEnd: DateTime.now().copyWith(hour: DateTime.now().hour + 1),
        inspectionTopic: 'Компетенция уполномоченного органа',
        inspectionType:
            'Региональный государственный контроль за использованием объектов нежилого фонда, находящихся в собственности города Москвы',
        inspectorId: 'B0ldh49PqRdcit67MtQC6X52B4g2',
        knoId:
            'ГОСУДАРСТВЕННАЯ ИНСПЕКЦИЯ ПО КОНТРОЛЮ ЗА ИСПОЛЬЗОВАНИЕМ ОБЪЕКТОВ НЕДВИЖИМОСТИ ГОРОДА МОСКВЫ',
        knoName:
            'Государственная инспекция по контролю за использованием объектов недвижимости города Москвы',
        status: 'Подтверждена',
        applicantId: 'XijMwKT4pFNUdZgCXF4PxaKgb2g2')
  ];
}
