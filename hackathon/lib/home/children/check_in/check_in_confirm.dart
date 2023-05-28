import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/text_styles.dart';

class CheckInConfirm extends StatelessWidget {
  const CheckInConfirm({
    super.key,
    required Kno selectedKno,
    required String selectedType,
    required String selectedTopic,
    required FreeSlot selectedSlot,
  })  : _selectedSlot = selectedSlot,
        _selectedTopic = selectedTopic,
        _selectedType = selectedType,
        _selectedKno = selectedKno;

  final Kno _selectedKno;
  final String _selectedType;
  final String _selectedTopic;
  final FreeSlot _selectedSlot;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Подтверждение данных',
          style: TextStyles.black18bold,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            width * 0.025, height * 0.01, width * 0.025, height * 0.1),
        child: Container(
          width: width * 0.95,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, offset: Offset(1, 1), blurRadius: 5)
              ]),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Text(
                  'Орган контроля',
                  style: TextStyles.black16bold,
                ),
                const SizedBox(height: 16),
                Text(_selectedKno.name),
                const SizedBox(height: 24),
                Text(
                  'Вид контроля',
                  style: TextStyles.black16bold,
                ),
                const SizedBox(height: 16),
                Text(_selectedType),
                const SizedBox(height: 24),
                Text(
                  'Тема консультирования',
                  style: TextStyles.black16bold,
                ),
                const SizedBox(height: 16),
                Text(_selectedTopic),
                const SizedBox(height: 24),
                Text(
                  'Дата и время',
                  style: TextStyles.black16bold,
                ),
                const SizedBox(height: 16),
                Text(
                  '${_selectedSlot.toDayMonth()}, ${_selectedSlot.toInterval()}',
                  style: TextStyles.black18
                      .copyWith(decoration: TextDecoration.underline),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          //TODO отдельный экран с блоком для обработки возможных ошибок
          final userId =
              context.read<AuthenticationRepository>().currentUser.id;
          FirebaseFirestore.instance
              .collection(
                  'inspectors/${_selectedKno.inspectors.first}/applications')
              .doc('$userId ${_selectedKno.id} ${_selectedSlot.start}')
              .set({
            'applicantId': userId,
            'inspectorId': _selectedKno.inspectors.first,
            'dateStart': _selectedSlot.start,
            'dateEnd': _selectedSlot.end,
            'inspectionType': _selectedType,
            'inspectionTopic': _selectedTopic,
            'kno': _selectedKno.id,
            'knoName': _selectedKno.name,
          });
          FirebaseFirestore.instance
              .collection('users/$userId/applications')
              .doc('$userId ${_selectedKno.id} ${_selectedSlot.start}')
              .set({
            'applicantId': userId,
            'inspectorId': _selectedKno.inspectors.first,
            'dateStart': _selectedSlot.start,
            'dateEnd': _selectedSlot.end,
            'inspectionType': _selectedType,
            'inspectionTopic': _selectedTopic,
            'kno': _selectedKno.id,
            'knoName': _selectedKno.name,
            'status': 'На рассмотрении',
          });
          FirebaseFirestore.instance
              .collection('kno/${_selectedKno.id}/freeSlots')
              .doc('${_selectedSlot.start}')
              .delete();
          await showDialog(
              barrierDismissible: false,
              useRootNavigator: false,
              context: context,
              builder: (context) {
                Future.delayed(const Duration(seconds: 3), () {
                  final nav = Navigator.of(context);
                  nav.pop(true);
                  nav.pop(true);
                  nav.pop(true);
                });
                return AlertDialog(
                  content: SizedBox(
                    height: 175,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Assets.icons.statusApproved.svg(height: 64),
                        const SizedBox(height: 10),
                        Text(
                          'Благодарим за ваше обращение!',
                          style: TextStyles.black16,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Запись на консультирование будет рассмотрена в ближайшее время.',
                          style: TextStyles.black14,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
                  ),
                );
              });
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width * 0.9,
              MediaQuery.of(context).size.height * 0.07),
        ),
        child: Text(
          'Подтвердить запись',
          style: GoogleFonts.inter().copyWith(fontSize: 16),
        ),
      ),
    );
  }
}
