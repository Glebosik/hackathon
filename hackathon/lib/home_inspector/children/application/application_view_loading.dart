import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/app/bloc/app_bloc.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home_inspector/view/home_bottom_nav_bar.dart';
import 'package:hackathon/text_styles.dart';

class ApplicationViewLoading extends StatelessWidget {
  const ApplicationViewLoading({super.key, required this.bottomKey});

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
      body: const Center(
        child: CircularProgressIndicator(color: ColorName.green),
      ),
      bottomNavigationBar: HomeInspectorBottomNavBar(
        key: bottomKey,
      ),
    );
  }
}
