import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/app/bloc/app_bloc.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/bloc/home_navigation_bloc.dart';
import 'package:hackathon/home/children/chat/chat_view%20copy.dart';
import 'package:hackathon/home/children/chat/chat_view.dart';
import 'package:hackathon/home/children/profile/profile_view.dart';
import 'package:hackathon/home/widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final HomeNavigationBloc homeNavigationBloc =
        context.read<HomeNavigationBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Assets.icons.logoName.svg(height: 56),
        actions: <Widget>[
          IconButton(
            key: const Key('HomeView_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AppBloc>().add(const AppLogoutRequested());
            },
          )
        ],
      ),
      body: BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
        builder: ((contex, state) {
          if (state is MainPageLoaded) {
            return Center(
                child: Column(
              children: [
                SizedBox(height: height * 0.05),
                SizedBox(
                  height: height * 0.2,
                  width: width,
                  child: const ResourcesListView(),
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.3,
                  width: width,
                  child: const ServiceList(),
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  width: width * 0.97,
                  child: const ConsultButton(),
                )
              ],
            ));
          } else if (state is ChatPageLoaded) {
            return const Center(
              child: ChatView(),
            );
          } else if (state is ConsultPageLoaded) {
            return const Center(
              child: ChatViewSocketIO(),
            );
          } else if (state is ProfilePageLoaded) {
            return Center(
              child: ProfileView(
                firstName: state.user.firstName,
                secondName: state.user.secondName,
                thirdName: state.user.thirdName,
              ),
            );
          }
          return Container();
        }),
      ),
      bottomNavigationBar: BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ColorName.orange,
            unselectedItemColor: ColorName.hyperlinkOrange,
            showUnselectedLabels: true,
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
            onTap: (index) => homeNavigationBloc.add(PageTapped(index)),
          );
        },
      ),
    );
  }
}
