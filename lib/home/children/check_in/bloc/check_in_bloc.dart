import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'check_in_event.dart';
part 'check_in_state.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final FirestoreRepository firestoreRepository;

  CheckInBloc({required this.firestoreRepository}) : super(CheckInInitial()) {
    on<CheckInEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CheckInFetchKno>((event, emit) async {
      emit(CheckKnoLoading());
      try {
        final data = await firestoreRepository.knoData;
        emit(CheckInKnoLoaded(data));
      } catch (e) {
        emit(CheckKnoLoadingFail());
      }
    });
  }
}
