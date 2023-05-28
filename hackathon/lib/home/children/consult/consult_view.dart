import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/bloc/home_navigation_bloc.dart';
import 'package:hackathon/home/children/check_in/check_in_view.dart';
import 'package:hackathon/home/children/consult/consult_detail_view.dart';
import 'package:hackathon/home/widgets/widgets.dart';
import 'package:hackathon/text_styles.dart';
import 'package:hackathon/utils/route_transitions.dart';

class ConsultView extends StatelessWidget {
  const ConsultView(
      {super.key, required this.bottomKey, required this.applications});

  final Key bottomKey;
  final List<Application> applications;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Консультации'),
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
              child: Container(
                width: width * 0.95,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1, 1),
                          blurRadius: 5)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: applications.length + 1,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        if (applications.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Ваши записи',
                              style: TextStyles.black18,
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ваши записи',
                                  style: TextStyles.black18,
                                ),
                                const SizedBox(height: 32),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'У вас пока нет записей на консультации',
                                    style: TextStyles.black16,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ApplicationCard(
                          application: applications[index - 1],
                          bottomKey: bottomKey,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
      floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(width * 0.95, height * 0.07)),
          onPressed: () async {
            final dynamic done = await Navigator.of(context)
                .push(createRoute(const CheckInView()));
            if (done is bool && done == true && context.mounted) {
              context.read<HomeNavigationBloc>().add(UpdateApplications());
            }
          },
          child: Text(
            'Записаться на консультирование',
            style: TextStyles.white16,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: HomeBottomNavBar(
        key: bottomKey,
      ),
    );
  }
}

class ApplicationCard extends StatelessWidget {
  const ApplicationCard({
    super.key,
    required this.application,
    required this.bottomKey,
  });

  final Application application;
  final Key bottomKey;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      elevation: 0,
      color: ColorName.backgroundOrange,
      child: InkWell(
        onTap: () async {
          dynamic result =
              await Navigator.of(context).push(createRoute(ConsultDetailView(
            bottomKey: bottomKey,
            application: application,
          )));
          if (result is String && result == 'Update' && context.mounted) {
            context.read<HomeNavigationBloc>().add(UpdateApplications());
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Запись на ${FreeSlot(application.dateStart, application.dateEnd).toDayMonth()} в ${FreeSlot(application.dateStart, application.dateEnd).toStartTime()}',
                  style: TextStyles.black14
                      .copyWith(color: ColorName.hyperlinkOrange),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                application.knoName,
                style: TextStyles.black14,
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      application.status == 'На рассмотрении'
                          ? Assets.icons.statusWaiting.svg()
                          : application.status == 'Подтверждена'
                              ? Assets.icons.statusApproved.svg()
                              : Assets.icons.statusDeclined.svg(),
                      SizedBox(width: width * 0.02),
                      Flexible(
                        child: Text(
                          application.status,
                          style:
                              TextStyles.black12.copyWith(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios, size: 16)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
