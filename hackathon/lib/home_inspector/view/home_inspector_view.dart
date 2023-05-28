import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/app/bloc/app_bloc.dart';
import 'package:hackathon/home_inspector/bloc/home_inspector_navigation_bloc.dart';
import 'package:hackathon/home_inspector/children/application/application_view.dart';
import 'package:hackathon/home_inspector/children/application/application_view_fail.dart';
import 'package:hackathon/home_inspector/children/application/application_view_loading.dart';
import 'package:hackathon/home_inspector/children/approved/approved_view.dart';
import 'package:hackathon/home_inspector/children/approved/approved_view_fail.dart';
import 'package:hackathon/home_inspector/children/approved/approved_view_loading.dart';

class HomeInspectorView extends StatelessWidget {
  const HomeInspectorView({super.key});

  @override
  Widget build(BuildContext context) {
    const Key bottomKey = Key('BottomBarKey');
    return BlocBuilder<HomeInspectorNavigationBloc,
        HomeInspectorNavigationState>(
      builder: (context, state) {
        if (state is ApplicationPageLoading) {
          return const ApplicationViewLoading(bottomKey: bottomKey);
        } else if (state is ApplicationPageLoaded) {
          return ApplicationView(
              bottomKey: bottomKey, applications: state.applications);
        } else if (state is ApplicationPageFailed) {
          return const ApplicationViewFail(bottomKey: bottomKey);
        } else if (state is ApprovedPageLoading) {
          return const ApprovedViewLoading(bottomKey: bottomKey);
        } else if (state is ApprovedPageLoaded) {
          return ApprovedView(
              bottomKey: bottomKey, applications: state.applications);
        } else if (state is ApprovedPageFailed) {
          return const ApprovedViewFail(bottomKey: bottomKey);
        }
        return Container();
      },
    );
  }

  AppBar inspectorAppBar(String title, BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
            onPressed: () {
              context.read<AppBloc>().add(const AppLogoutRequested());
            },
            icon: const Icon(Icons.exit_to_app))
      ],
    );
  }
}
