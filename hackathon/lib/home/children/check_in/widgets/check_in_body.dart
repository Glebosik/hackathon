import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/children/calendar/bloc/calendar_bloc.dart';
import 'package:hackathon/home/children/check_in/check_in_confirm.dart';
import 'package:hackathon/home/children/children.dart';
import 'package:hackathon/text_styles.dart';
import 'package:hackathon/utils/route_transitions.dart';

class CheckInBody extends StatefulWidget {
  const CheckInBody({
    required this.knos,
    super.key,
  });
  final List<Kno> knos;

  @override
  State<CheckInBody> createState() => _CheckInBodyState();
}

class _CheckInBodyState extends State<CheckInBody> {
  Kno? _selectedKno;
  String? _selectedType;
  String? _selectedTopic;
  FreeSlot? _selectedSlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Запись на консультирование',
          style: TextStyles.black18bold,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Орган контроля',
                style: TextStyles.black16bold,
              ),
              const SizedBox(height: 16),
              knoDropDown(),
              const SizedBox(height: 24),
              Text(
                'Вид контроля',
                style: TextStyles.black16bold,
              ),
              const SizedBox(height: 16),
              typesDropDown(),
              const SizedBox(height: 24),
              Text(
                'Тема консультирования',
                style: TextStyles.black16bold,
              ),
              const SizedBox(height: 16),
              topicsDropDown(),
              const SizedBox(height: 24),
              Text(
                'Дата и время',
                style: TextStyles.black16bold,
              ),
              const SizedBox(height: 16),
              datePick(),
              const SizedBox(height: 24),
              const Spacer(),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.9,
                          MediaQuery.of(context).size.height * 0.07),
                    ),
                    onPressed: (_selectedKno != null &&
                            _selectedSlot != null &&
                            _selectedTopic != null &&
                            _selectedType != null)
                        ? () {
                            Navigator.of(context).push(
                              createRoute(
                                CheckInConfirm(
                                  selectedKno: _selectedKno!,
                                  selectedType: _selectedType!,
                                  selectedTopic: _selectedTopic!,
                                  selectedSlot: _selectedSlot!,
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Text(
                      'Записаться на консультирование',
                      style: GoogleFonts.inter().copyWith(fontSize: 16),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container knoDropDown() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorName.backgroundOrange,
      ),
      child: DropdownButton(
        itemHeight: 50,
        hint: Text(
          'Не выбран',
          style: TextStyles.black14.copyWith(color: Colors.grey),
          overflow: TextOverflow.ellipsis,
        ),
        value: _selectedKno,
        selectedItemBuilder: (context) {
          return widget.knos.map<Widget>((kno) {
            return Center(
              child: Text(
                kno.name,
                style: TextStyles.black14,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList();
        },
        items: widget.knos.map<DropdownMenuItem<Kno>>((kno) {
          return DropdownMenuItem<Kno>(
            value: kno,
            child: Text(
              kno.name,
              style: TextStyles.black14,
              overflow: TextOverflow.fade,
            ),
          );
        }).toList(),
        onChanged: (Kno? kno) {
          setState(() {
            if (_selectedKno != kno) {
              _selectedSlot = null;
              _selectedTopic = null;
              _selectedType = null;
              _selectedKno = kno;
            }
          });
        },
        isExpanded: true,
        underline: const SizedBox(),
        icon: Assets.icons.arrowDown.svg(height: 10),
      ),
    );
  }

  Container typesDropDown() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorName.backgroundOrange,
      ),
      child: DropdownButton(
        hint: Text(
          'Не выбран',
          style: TextStyles.black14.copyWith(color: Colors.grey),
          overflow: TextOverflow.ellipsis,
        ),
        value: _selectedType,
        selectedItemBuilder: (context) {
          if (_selectedKno != null) {
            return _selectedKno!.inspectionTypes.keys.map<Widget>((type) {
              return Center(
                child: Text(
                  type,
                  style: TextStyles.black14,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList();
          } else {
            return [];
          }
        },
        items: _selectedKno != null
            ? _selectedKno!.inspectionTypes.keys
                .map<DropdownMenuItem<String>>((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(
                    type,
                    style: TextStyles.black14,
                    overflow: TextOverflow.fade,
                  ),
                );
              }).toList()
            : null,
        onChanged: (String? type) {
          setState(() {
            if (_selectedType != type) {
              _selectedTopic = null;
              _selectedType = type;
            }
          });
        },
        isExpanded: true,
        underline: const SizedBox(),
        icon: Assets.icons.arrowDown.svg(height: 10),
      ),
    );
  }

  Container topicsDropDown() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorName.backgroundOrange,
      ),
      child: DropdownButton(
        hint: Text(
          'Не выбрана',
          style: TextStyles.black14.copyWith(color: Colors.grey),
          overflow: TextOverflow.ellipsis,
        ),
        value: _selectedTopic,
        selectedItemBuilder: (context) {
          if (_selectedType != null) {
            return _selectedKno!.inspectionTypes[_selectedType]!
                .map<Widget>((type) {
              return Center(
                child: Text(
                  type,
                  style: TextStyles.black14,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList();
          } else {
            return [];
          }
        },
        items: _selectedType != null
            ? _selectedKno!.inspectionTypes[_selectedType]!
                .map<DropdownMenuItem<String>>((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(
                    type,
                    style: TextStyles.black14,
                    overflow: TextOverflow.fade,
                  ),
                );
              }).toList()
            : null,
        onChanged: (String? topic) {
          setState(() {
            if (_selectedTopic != topic) {
              _selectedTopic = topic;
            }
          });
        },
        isExpanded: true,
        underline: const SizedBox(),
        icon: Assets.icons.arrowDown.svg(height: 10),
      ),
    );
  }

  Widget datePick() {
    return _selectedSlot != null
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorName.backgroundOrange,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${_selectedSlot!.toDayMonth()}, ${_selectedSlot!.toInterval()}'),
                  IconButton(
                      onPressed: () async {
                        context
                            .read<CalendarBloc>()
                            .add(CalendarLoad(_selectedKno!.id));
                        final slot = await showDialog(
                          useRootNavigator: false,
                          context: context,
                          builder: (context) {
                            return const Dialog(
                              insetPadding:
                                  EdgeInsets.only(left: 20, right: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: CalendarView(),
                            );
                          },
                        );
                        setState(() {
                          if (slot != null) {
                            _selectedSlot = slot;
                          }
                        });
                      },
                      icon: const Icon(Icons.calendar_month_outlined))
                ],
              ),
            ))
        : ElevatedButton(
            style: ElevatedButtonTheme.of(context).style!.copyWith(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)))),
            onPressed: _selectedKno != null
                ? () async {
                    context
                        .read<CalendarBloc>()
                        .add(CalendarLoad(_selectedKno!.id));
                    final slot = await showDialog(
                      useRootNavigator: false,
                      context: context,
                      builder: (context) {
                        return const Dialog(
                          insetPadding: EdgeInsets.only(left: 20, right: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: CalendarView(),
                        );
                      },
                    );
                    setState(() {
                      if (slot != null) {
                        _selectedSlot = slot;
                      }
                    });
                  }
                : null,
            child: const Text('Выбрать'));
  }
}
