import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/text_styles.dart';

class ApplicationDetailView extends StatelessWidget {
  const ApplicationDetailView(
      {super.key, required this.bottomKey, required this.applicationUser});

  final Key bottomKey;
  final ApplicationUser applicationUser;

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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorName.greenDark,
                  fixedSize: Size(width * 0.95, height * 0.07)),
              onPressed: () async {
                context
                    .read<FirestoreRepository>()
                    .approveApplication(application);
                Navigator.of(context).pop('Update');
              },
              child: Text(
                'Подтвердить консультацию',
                style: GoogleFonts.inter().copyWith(fontSize: 16),
              )),
          SizedBox(height: height * 0.03),
          TextButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(width * 0.95, height * 0.07),
              ),
              onPressed: () async {
                context
                    .read<FirestoreRepository>()
                    .declineApplication(application);

                Navigator.of(context).pop('Update');
              },
              child: Text(
                'Отклонить',
                style: GoogleFonts.inter()
                    .copyWith(fontSize: 16, color: Colors.black),
              )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
