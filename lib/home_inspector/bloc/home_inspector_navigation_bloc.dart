import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firestore_repository/firestore_repository.dart';

part 'home_inspector_navigation_event.dart';
part 'home_inspector_navigation_state.dart';

class HomeInspectorNavigationBloc
    extends Bloc<HomeInspectorNavigationEvent, HomeInspectorNavigationState> {
  final FirestoreRepository firestoreRepository;
  int currentIndex = 0;
  User? user;
  List<ApplicationUser> applications = [];
  List<ApplicationUser> approved = [];
  final List<ApplicationUser> testApproved = [
    ApplicationUser(
        user: const User(
            email: 'test1@test.ru',
            phoneNumber: '',
            firstName: 'Тест',
            secondName: 'Тестов',
            thirdName: 'Тестович',
            approved: true),
        application: Application(
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
            applicantId: 'XijMwKT4pFNUdZgCXF4PxaKgb2g2'))
  ];

  HomeInspectorNavigationBloc({required this.firestoreRepository})
      : super(HomeNavigationInitial()) {
    on<HomeInspectorNavigationEvent>((event, emit) {});

    on<UpdateApplications>((event, emit) async {
      applications =
          await firestoreRepository.getInspectorApplicationsWaiting();
      applications.sort(
          (a, b) => a.application.dateStart.compareTo(b.application.dateStart));
    });

    on<UpdateApproved>((event, emit) async {
      if (auth.FirebaseAuth.instance.currentUser!.email != 'test2@test.ru') {
        approved = await firestoreRepository.getInspectorApplicationsApproved();
        approved.sort((a, b) =>
            a.application.dateStart.compareTo(b.application.dateStart));
      } else {
        approved = testApproved;
      }
    });

    on<PageTapped>((event, emit) async {
      currentIndex = event.index;
      if (event.index == 0) {
        emit(ApplicationPageLoading());
        try {
          if (applications.isEmpty) {
            applications =
                await firestoreRepository.getInspectorApplicationsWaiting();
            applications.sort((a, b) =>
                a.application.dateStart.compareTo(b.application.dateStart));
          }
          emit(ApplicationPageLoaded(applications));
        } catch (e) {
          emit(ApplicationPageFailed());
        }
      } else if (event.index == 1) {
        emit(ApprovedPageLoading());
        try {
          if (auth.FirebaseAuth.instance.currentUser!.email !=
              'test2@test.ru') {
            if (approved.isEmpty) {
              approved =
                  await firestoreRepository.getInspectorApplicationsApproved();
              approved.sort((a, b) =>
                  a.application.dateStart.compareTo(b.application.dateStart));
            }
          } else {
            approved = testApproved;
          }
          emit(ApprovedPageLoaded(approved));
        } catch (e) {
          emit(ApprovedPageFailed());
        }
      }
    });
  }
}
