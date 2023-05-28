import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/app/bloc/app_bloc.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/home_inspector/view/home_bottom_nav_bar.dart';
import 'package:hackathon/text_styles.dart';

import 'approved_card.dart';

class ApprovedView extends StatelessWidget {
  const ApprovedView(
      {super.key, required this.bottomKey, required this.applications});

  final Key bottomKey;
  final List<ApplicationUser> applications;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Assets.icons.inspectorLogo.svg(height: 48),
        title: Text(
          'Подтвержденные консультации',
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
      body: applications.isEmpty
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.icons.approvedBackground.svg(width: width * 0.3),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'У вас пока нет записей на консультацию',
                      style: GoogleFonts.inter().copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.025, height * 0.01, width * 0.025, height * 0.1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: applications.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ApprovedCard(
                        applicationUser: applications[index],
                        bottomKey: bottomKey,
                      ),
                    );
                  },
                ),
              ),
            ),
      bottomNavigationBar: HomeInspectorBottomNavBar(
        key: bottomKey,
      ),
    );
  }
}
