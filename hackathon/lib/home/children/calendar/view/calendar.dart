import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/children/calendar/bloc/calendar_bloc.dart';
import 'package:hackathon/text_styles.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<FreeSlot> _availableSlots = [];
  FreeSlot? _selectedSlot;

  @override
  void initState() {
    super.initState();
    if (DateTime.now().isBefore(DateTime(2023, DateTime.june, 1))) {
      _focusedDay = DateTime(2023, DateTime.june, 1);
    }
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          if (state is CalendarLoading) {
            return SizedBox(
              height: height * 0.7,
              width: width * 0.95,
              child: const Center(
                  child: CircularProgressIndicator(
                color: ColorName.orange,
              )),
            );
          } else if (state is CalendarLoaded) {
            _availableSlots = state.events[_selectedDay] ?? [];
            return SizedBox(
              height: height * 0.7,
              width: width * 0.95,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TableCalendar<FreeSlot>(
                    locale: 'ru_RU',
                    firstDay: DateTime(2023, DateTime.june, 1),
                    lastDay: DateTime(2023, DateTime.august, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Месяц',
                    },
                    calendarFormat: CalendarFormat.month,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: const CalendarStyle(
                      // Use `CalendarStyle` to customize the UI
                      outsideDaysVisible: false,
                    ),
                    onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          _availableSlots = state.events[selectedDay] ?? [];
                        });
                      }
                    },
                    calendarBuilders: CalendarBuilders(
                        prioritizedBuilder: (context, day, focusedDay) {
                      Color color;
                      if (state.events.containsKey(day)) {
                        if (state.events[day]!.length < 4) {
                          color = ColorName.orange;
                        } else if (state.events[day]!.length < 8) {
                          color = ColorName.backgroundOtherOrange;
                        } else {
                          color = ColorName.greenLight;
                        }
                      } else {
                        color = Colors.grey;
                      }
                      return Center(
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: day == focusedDay
                                ? Border.all(width: 2, color: ColorName.green)
                                : null,
                          ),
                          child: Center(child: Text('${day.day}')),
                        ),
                      );
                    }),
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: _availableSlots.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'На выбранный день нет доступных записей',
                                textAlign: TextAlign.center,
                                style: TextStyles.black14,
                              ),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _availableSlots.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, right: 4),
                                child: ChoiceChip(
                                  backgroundColor: Colors.white,
                                  selectedColor: Colors.white,
                                  shape: _selectedSlot == _availableSlots[index]
                                      ? RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          side: const BorderSide(
                                              color: ColorName.orange))
                                      : RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          side: const BorderSide()),
                                  label: Text(
                                      _availableSlots[index].toInterval(),
                                      style: _selectedSlot ==
                                              _availableSlots[index]
                                          ? TextStyles.black14
                                              .copyWith(color: ColorName.orange)
                                          : TextStyles.black14),
                                  selected:
                                      _selectedSlot == _availableSlots[index],
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _selectedSlot = selected
                                          ? _availableSlots[index]
                                          : null;
                                    });
                                  },
                                ),
                              );
                            }),
                  ),
                  ElevatedButton(
                    onPressed: _selectedSlot != null
                        ? () {
                            Navigator.of(context).pop(_selectedSlot);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(width * 0.7, height * 0.06),
                    ),
                    child: Text(
                      'Выбрать',
                      style: GoogleFonts.inter().copyWith(fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CalendarFailed) {
            return SizedBox(
              height: height * 0.7,
              width: width * 0.95,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                        'Не удалось получить данные о свободных слотах для записи :('),
                    const Text(
                        'Проверьте подключение к интернету и повторите попытку'),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<CalendarBloc>()
                            .add(CalendarLoad(state.knoId));
                      },
                      child: const Text('Попробовать еще раз'),
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('Упс... Что-то пошло не так.'));
        },
      ),
    );
  }
}
