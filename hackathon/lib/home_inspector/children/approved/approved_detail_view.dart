import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/children/conference/bloc/conference_bloc.dart';
import 'package:hackathon/home/children/conference/conference_page.dart';
import 'package:hackathon/text_styles.dart';
import 'package:hackathon/utils/route_transitions.dart';

class ApprovedDetailView extends StatelessWidget {
  ApprovedDetailView(
      {super.key, required this.bottomKey, required this.applicationUser});

  final Key bottomKey;
  final ApplicationUser applicationUser;
  final isTest = FirebaseAuth.instance.currentUser!.email == 'test2@test.ru';

  @override
  Widget build(BuildContext context) {
    final application = applicationUser.application;
    final user = applicationUser.user;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final slot = FreeSlot(application.dateStart, application.dateEnd);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Консультация'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              width * 0.025, height * 0.01, width * 0.025, height * 0.1),
          child: Column(
            children: [
              Container(
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
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Text(
                        'Инициатор консультации',
                        style: TextStyles.black16bold,
                      ),
                      const SizedBox(height: 16),
                      Text(
                          'ИП «${user.secondName} ${user.firstName}${user.thirdName != null ? ' ${user.thirdName}' : ''}»'),
                      const SizedBox(height: 24),
                      Text(
                        'Вид контроля',
                        style: TextStyles.black16bold,
                      ),
                      const SizedBox(height: 16),
                      Text(application.inspectionType),
                      const SizedBox(height: 24),
                      Text(
                        'Тема консультирования',
                        style: TextStyles.black16bold,
                      ),
                      const SizedBox(height: 16),
                      Text(application.inspectionTopic),
                      const SizedBox(height: 24),
                      Text(
                        'Дата и время',
                        style: TextStyles.black16bold,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${slot.toDayMonth()}, ${slot.toInterval()}',
                            style: TextStyles.black18
                                .copyWith(decoration: TextDecoration.underline),
                          ),
                          isTest
                              ? Container()
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: ColorName.disabledBackground),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () async {
                                    final dynamic isToDelete = await showDialog(
                                        barrierDismissible: false,
                                        useRootNavigator: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: SizedBox(
                                              height: 175,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child: Center(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Assets.icons.deleteSign
                                                      .svg(height: 64),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    'Вы уверены, что хотите отменить консультацию?',
                                                    style: TextStyles.black16,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    'Статус заявки будет изменена на Отклонена',
                                                    style: TextStyles.black14,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              )),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: Text(
                                                  'Назад',
                                                  style: GoogleFonts.inter()
                                                      .copyWith(
                                                          color:
                                                              ColorName.green),
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(true);
                                                  },
                                                  child: const Text(
                                                      'Отменить консультацию')),
                                            ],
                                          );
                                        });
                                    if (isToDelete is bool &&
                                        isToDelete == true &&
                                        context.mounted) {
                                      context
                                          .read<FirestoreRepository>()
                                          .declineApplication(application);
                                      Navigator.of(context).pop('Update');
                                    }
                                  },
                                  child: Text(
                                    'Отменить',
                                    style: GoogleFonts.inter().copyWith(
                                        color: ColorName.disabledBackground),
                                  ),
                                )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: ColorName.disabledBackground,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1, 1),
                          blurRadius: 5)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children:
                          (slot.start.difference(DateTime.now()).inMinutes > 15)
                              ? [
                                  Text(
                                    'До консультации:',
                                    style: TextStyles.white16,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    slot.remainginTime(),
                                    style: TextStyles.white16,
                                  ),
                                ]
                              : (slot.start
                                          .difference(DateTime.now())
                                          .inMinutes >
                                      0)
                                  ? [
                                      Text(
                                        'Консультация скоро начнется.',
                                        style: TextStyles.white16,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Вы уже можете подключиться.',
                                        style: TextStyles.white16,
                                      ),
                                    ]
                                  : [
                                      Text(
                                        'Консультация уже началась!',
                                        style: TextStyles.white16,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Подключайтесь, вас ожидают.',
                                        style: TextStyles.white16,
                                      ),
                                    ]),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: isTest
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorName.greenDark,
                  fixedSize: Size(width * 0.95, height * 0.07)),
              onPressed: (slot.start.difference(DateTime.now()).inMinutes > 15)
                  ? null
                  : () {
                      context.read<ConferenceBloc>().add(ConferenceStart());
                      Navigator.of(context)
                          .push(createRoute(const ConferencePage(uid: 2)));
                    },
              child: Text(
                'Подключиться к консультации',
                style: GoogleFonts.inter().copyWith(fontSize: 16),
              ))
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorName.greenDark,
                  fixedSize: Size(width * 0.95, height * 0.07)),
              onPressed: (slot.start.difference(DateTime.now()).inMinutes > 15)
                  ? null
                  : () {},
              child: Text(
                'Подключиться к консультации',
                style: GoogleFonts.inter().copyWith(fontSize: 16),
              )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
