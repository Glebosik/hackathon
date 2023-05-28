import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'conference_event.dart';
part 'conference_state.dart';

class ConferenceBloc extends Bloc<ConferenceEvent, ConferenceState> {
  final FirestoreRepository firestoreRepository;
  ConferenceBloc({required this.firestoreRepository})
      : super(ConferenceInitial()) {
    on<ConferenceEvent>((event, emit) {});
    on<ConferenceStart>((event, emit) async {
      emit(ConferenceLoading());
      try {
        final data = await firestoreRepository.getConferenceData();
        final token = data['token'];
        final channel = data['channel'];
        final appId = data['appId'];
        emit(ConferenceReady(token, channel, appId));
      } catch (e) {
        emit(ConferenceFail());
      }
    });
  }
}
