import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/app/app.dart';
import 'package:hackathon/home/children/calendar/bloc/calendar_bloc.dart';
import 'package:hackathon/home/children/chat/bloc/chat_bloc.dart';
import 'package:hackathon/home/children/check_in/bloc/check_in_bloc.dart';
import 'package:hackathon/home/children/conference/bloc/conference_bloc.dart';
import 'package:hackathon/home_inspector/bloc/home_inspector_navigation_bloc.dart';
import 'package:hackathon/theme.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    required FirestoreRepository firestoreRepository,
    required this.status,
    super.key,
  })  : _authenticationRepository = authenticationRepository,
        _firestoreRepository = firestoreRepository;

  final AuthenticationRepository _authenticationRepository;
  final FirestoreRepository _firestoreRepository;
  final bool? status;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider.value(
          value: _firestoreRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(
              authenticationRepository: _authenticationRepository,
              status: status,
            ),
          ),
          BlocProvider(
            create: (context) => MyChatBloc(),
          ),
          BlocProvider(
              create: (context) =>
                  CheckInBloc(firestoreRepository: _firestoreRepository)
                    ..add(CheckInFetchKno())),
          BlocProvider(
              create: (context) =>
                  CalendarBloc(firestoreRepository: _firestoreRepository)),
          BlocProvider(
              create: (context) => HomeInspectorNavigationBloc(
                  firestoreRepository: _firestoreRepository)),
          BlocProvider(
              create: (context) =>
                  ConferenceBloc(firestoreRepository: _firestoreRepository)),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
