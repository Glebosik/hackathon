import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/home/bloc/home_navigation_bloc.dart';
import 'package:hackathon/home/children/children.dart';
import 'package:hackathon/home/children/profile/profile_view_shimmer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const Key bottomKey = Key('BottomBarKey');
    return BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
      builder: (context, state) {
        if (state is MainPageLoaded) {
          return const MainView(bottomKey: bottomKey);
        } else if (state is ChatPageLoaded) {
          return const ChatView(bottomKey: bottomKey);
        } else if (state is ConsultPageLoaded) {
          return const ConsultView(bottomKey: bottomKey);
        } else if (state is ProfilePageLoading) {
          return const ProfileViewShimmer(
            bottomKey: bottomKey,
          );
        } else if (state is ProfilePageLoaded) {
          return ProfileView(
            user: state.user,
            bottomKey: bottomKey,
          );
        }
        return Container();
      },
    );
  }
}
