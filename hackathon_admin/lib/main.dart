import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_admin/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppView(),
    );
  }
}

class InspectionType {
  const InspectionType(this.knoName, this.inspectionType, this.topics);
  final String knoName;
  final String inspectionType;
  final List<String> topics;
}

class AppView extends StatelessWidget {
  AppView({
    super.key,
  });

  final CollectionReference kno = FirebaseFirestore.instance.collection('kno');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: updateSlotsForAll,
              child: const Text('Обновить слоты для записи'),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: updateTypesAndTopicsForAll,
              child: const Text('Обновить виды и темы контроля'),
            ),
          ],
        ),
      ),
    );
  }

  void updateTypesAndTopicsForAll() async {
    var picked = await FilePicker.platform.pickFiles();

    if (picked != null) {
      final excel = Excel.decodeBytes(picked.files.first.bytes!);
      final table = excel.tables.keys.elementAt(1);
      final rows = excel.tables[table]?.maxRows ?? 0;
      Map<String, Map<String, Set<String>>> collection = {};
      for (int i = 1; i < rows; ++i) {
        final row = excel.tables[table]!.row(i);
        String knoName = row[1]!.value.toString().toUpperCase();
        if (knoName == 'МОСГОРНАСЛЕДИЕ') {
          knoName = 'ДЕПАРТАМЕНТ КУЛЬТУРНОГО НАСЛЕДИЯ ГОРОДА МОСКВЫ';
        }
        final inspectionType = row[2]!.value.toString();
        final consultTopic = row[3]!.value.toString();
        if (collection.containsKey(knoName)) {
          if (collection[knoName]!.containsKey(inspectionType)) {
            collection[knoName]![inspectionType]!.add(consultTopic);
          } else {
            collection[knoName]![inspectionType] = {consultTopic};
          }
        } else {
          collection[knoName] = {
            inspectionType: {consultTopic}
          };
        }
      }
      collection.forEach((knoName, inspectionTypeMap) {
        inspectionTypeMap.forEach((inspectionType, topicSet) {
          CollectionReference ref = FirebaseFirestore.instance
              .collection('kno/$knoName/inspectionType');
          ref.doc(inspectionType).set({
            'topics': topicSet.toList(),
          });
        });
      });
    }
  }

  void updateSlotsForAll() async {
    var picked = await FilePicker.platform.pickFiles();
    if (picked != null) {
      final excel = Excel.decodeBytes(picked.files.first.bytes!);
      for (int i = 9; i < 10; ++i) {
        //Нулевая таблица не содержит нужных данных
        final table = excel.tables.keys.elementAt(i);
        //final cols = excel.tables[table]?.maxCols ?? 0;
        final rows = excel.tables[table]?.maxRows ?? 0;
        int? beginningOfData;
        String knoName = excel.tables[table]!.row(0).first!.value.toString();
        print('ДО: $knoName');
        if (knoName.contains('(')) {
          knoName = knoName.replaceRange(
              knoName.indexOf('(') - 1, knoName.length, '');
        }
        print('После: $knoName');
        //Ищем где начинаются данные
        bool flag = false;
        for (int j = 3; j < 15; ++j) {
          final row = excel.tables[table]!.row(j);
          for (var data in row) {
            if (data?.value != null) {
              if (data!.value.toString().contains('Слоты')) {
                beginningOfData = j + 2;
                flag = true;
                break;
              }
            }
          }
          if (flag) {
            break;
          }
        }

        if (beginningOfData != null) {
          FirebaseFirestore.instance
              .collection('kno')
              .doc(knoName.toUpperCase())
              .set({
            'name': knoName,
            'inspectorsId': [],
          });
          CollectionReference freeSlots = FirebaseFirestore.instance
              .collection('kno/${knoName.toUpperCase()}/freeSlots');
          for (int j = beginningOfData ?? rows; j < rows; ++j) {
            final row = excel.tables[table]!.row(j);
            //Первый месяц
            if (!row[0].isNull && !row[1].isNull) {
              final interval = row[1]!.value.toString().split('-');
              if (interval.first.length == 4) {
                interval.first = '0${interval.first}';
              }
              if (interval.last.length == 4) {
                interval.last = '0${interval.last}';
              }
              DateTime dateStart = DateTime.parse(
                  "${row[0]!.value.toString().substring(0, 11)}${interval.first}");
              DateTime dateEnd = DateTime.parse(
                  "${row[0]!.value.toString().substring(0, 11)}${interval.last}");
              freeSlots.doc(dateStart.toString()).set({
                "dateStart": dateStart,
                "dateEnd": dateEnd,
              });
            }
            //Второй месяц
            if (!row[3].isNull && !row[4].isNull) {
              final interval = row[4]!.value.toString().split('-');
              if (interval.first.length == 4) {
                interval.first = '0${interval.first}';
              }
              if (interval.last.length == 4) {
                interval.last = '0${interval.last}';
              }
              DateTime dateStart = DateTime.parse(
                  "${row[3]!.value.toString().substring(0, 11)}${interval.first}");
              DateTime dateEnd = DateTime.parse(
                  "${row[3]!.value.toString().substring(0, 11)}${interval.last}");
              freeSlots.doc(dateStart.toString()).set({
                "dateStart": dateStart,
                "dateEnd": dateEnd,
              });
            }
            //Третий месяц
            if (!row[6].isNull && !row[7].isNull) {
              final interval = row[7]!.value.toString().split('-');
              if (interval.first.length == 4) {
                interval.first = '0${interval.first}';
              }
              if (interval.last.length == 4) {
                interval.last = '0${interval.last}';
              }
              DateTime dateStart = DateTime.parse(
                  "${row[6]!.value.toString().substring(0, 11)}${interval.first}");
              DateTime dateEnd = DateTime.parse(
                  "${row[6]!.value.toString().substring(0, 11)}${interval.last}");
              freeSlots.doc(dateStart.toString()).set({
                "dateStart": dateStart,
                "dateEnd": dateEnd,
              });
            }
          }
        }
      }
    }
  }
}
