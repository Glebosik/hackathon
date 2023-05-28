import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/home_inspector/bloc/home_inspector_navigation_bloc.dart';
import 'package:hackathon/home_inspector/view/home_inspector_view.dart';
import 'package:page_transition/page_transition.dart';

class HomeInspectorSplash extends StatelessWidget {
  const HomeInspectorSplash({super.key});

  static Page<void> page() =>
      const MaterialPage<void>(child: HomeInspectorSplash());

  @override
  Widget build(BuildContext context) {
    return /*AnimatedSplashScreen(
      splash: Assets.icons.logoNameDark.svg(),
      nextScreen:*/
        MultiBlocProvider(providers: [
      BlocProvider(
          create: (_) => HomeInspectorNavigationBloc(
              firestoreRepository: context.read<FirestoreRepository>())
            ..add(const PageTapped(0)))
    ], child: const HomeInspectorView()) /*,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      duration: 2500,
    )*/
        ;
  }
}
