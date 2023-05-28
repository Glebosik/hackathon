import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/app/bloc/app_bloc.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/home_inspector/bloc/home_inspector_navigation_bloc.dart';
import 'package:hackathon/home_inspector/view/home_bottom_nav_bar.dart';
import 'package:hackathon/text_styles.dart';

class ApprovedViewFail extends StatelessWidget {
  const ApprovedViewFail({super.key, required this.bottomKey});

  final Key bottomKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Assets.icons.inspectorLogo.svg(height: 48),
        title: Text(
          'Консультации, ожидающие подтверждения',
          style: TextStyles.black16,
          maxLines: 2,
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AppBloc>().add(const AppLogoutRequested());
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
              'Не удалось получить данные о ваших записях на консультирования'),
          const Text('Проверьте подключение к интернету и попробуйте снова'),
          ElevatedButton(
              onPressed: () {
                context
                    .read<HomeInspectorNavigationBloc>()
                    .add(const PageTapped(1));
              },
              child: const Text('Попробовать снова')),
        ],
      )),
      bottomNavigationBar: HomeInspectorBottomNavBar(key: bottomKey),
    );
  }
}
