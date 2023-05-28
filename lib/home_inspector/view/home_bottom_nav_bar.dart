import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/home_inspector/bloc/home_inspector_navigation_bloc.dart';

class HomeInspectorBottomNavBar extends StatelessWidget {
  const HomeInspectorBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeInspectorNavigationBloc homeInspectorNavigationBloc =
        context.read<HomeInspectorNavigationBloc>();
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      currentIndex: homeInspectorNavigationBloc.currentIndex,
      items: [
        BottomNavigationBarItem(
          label: 'Ожидают подтверждения',
          icon: Assets.icons.inspectorApplications.svg(),
        ),
        BottomNavigationBarItem(
          label: 'Подтверждены',
          icon: Assets.icons.inspectorApproved.svg(),
        ),
      ],
      onTap: (index) => homeInspectorNavigationBloc.add(PageTapped(index)),
    );
  }
}
