import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/bloc/home_navigation_bloc.dart';
import 'package:hackathon/home/children/chat/bloc/chat_bloc.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeNavigationBloc homeNavigationBloc =
        context.read<HomeNavigationBloc>();
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorName.orange,
      unselectedItemColor: ColorName.hyperlinkOrange,
      showUnselectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 10,
      currentIndex: homeNavigationBloc.currentIndex,
      items: [
        BottomNavigationBarItem(
          label: 'Главная',
          icon: Assets.icons.bottomMain.svg(),
        ),
        BottomNavigationBarItem(
          label: 'Чат-бот',
          icon: Assets.icons.bottomChat.svg(),
        ),
        BottomNavigationBarItem(
          label: 'Консультация',
          icon: Assets.icons.bottomConsult.svg(),
        ),
        BottomNavigationBarItem(
          label: 'Профиль',
          icon: Assets.icons.bottomProfile.svg(),
        ),
      ],
      onTap: (index) {
        if (index == 1) {
          context.read<MyChatBloc>().add(ChatInit());
        }
        homeNavigationBloc.add(PageTapped(index));
      },
    );
  }
}
