import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/home/bloc/home_navigation_bloc.dart';
import 'package:hackathon/home/children/children.dart';
import 'package:hackathon/home/children/consult/consult_view_fail.dart';
import 'package:hackathon/home/children/consult/consult_view_loading.dart';
import 'package:hackathon/home/children/profile/profile_view_fail.dart';
import 'package:hackathon/home/children/profile/profile_view_loading.dart';

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
        } else if (state is ConsultPageLoading) {
          return const ConsultViewLoading(bottomKey: bottomKey);
        } else if (state is ConsultPageLoaded) {
          return ConsultView(
            bottomKey: bottomKey,
            applications: state.applications,
          );
        } else if (state is ConsultPageFailed) {
          return const ConsultViewFail(bottomKey: bottomKey);
        } else if (state is ProfilePageLoading) {
          return const ProfileViewLoading(
            bottomKey: bottomKey,
          );
        } else if (state is ProfilePageLoaded) {
          return ProfileView(
            user: state.user,
            bottomKey: bottomKey,
          );
        } else if (state is ProfilePageFailed) {
          return const ProfileViewFail(bottomKey: bottomKey);
        }
        return Container();
      },
    );
  }
}
