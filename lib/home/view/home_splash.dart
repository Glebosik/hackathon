import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/home/bloc/home_navigation_bloc.dart';
import 'package:hackathon/home/view/home_view.dart';
import 'package:page_transition/page_transition.dart';

class HomeSplash extends StatelessWidget {
  const HomeSplash({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomeSplash());

  @override
  Widget build(BuildContext context) {
    return /*AnimatedSplashScreen(
      splash: Assets.icons.logoName.svg(),
      nextScreen:*/
        MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) => HomeNavigationBloc(
              firestoreRepository: context.read<FirestoreRepository>())
            ..add(Init()))
    ], child: const HomeView())
        /*,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      duration: 2500,
    )*/
        ;
  }
}
