import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/home/widgets/widgets.dart';

class ServiceList extends StatefulWidget {
  const ServiceList({
    super.key,
  });

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  late Timer _timer;
  final _pageController = PageController(
    viewportFraction: 0.98,
    initialPage: 0,
  );

  void autoScroll(timer) {
    if (_pageController.page!.round() < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.ease,
      );
    } else {
      _pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 350),
        curve: Curves.ease,
      );
    }
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 5), autoScroll);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void onAnyTouch() {
    _timer.cancel();
    _timer = Timer(const Duration(seconds: 15), () {
      _timer = Timer.periodic(const Duration(seconds: 5), autoScroll);
    });
  }

  void onAnyTouchDetails(DragEndDetails details) {
    (details.primaryVelocity ?? 0) < 0
        ? _pageController.nextPage(
            duration: const Duration(milliseconds: 350),
            curve: Curves.ease,
          )
        : _pageController.previousPage(
            duration: const Duration(milliseconds: 350),
            curve: Curves.ease,
          );
    _timer.cancel();
    _timer = Timer(const Duration(seconds: 15), () {
      _timer = Timer.periodic(const Duration(seconds: 5), autoScroll);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAnyTouch,
      onHorizontalDragEnd: onAnyTouchDetails,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          ServiceCard(
            title: 'Жалоба на решение органов контроля',
            subtitle:
                'С помощью данной услуги вы можете подать жалобу на контролирующий орган, если, по вашему мнению, при осуществлении государственного контроля (надзора) были нарушены ваши права или законные интересы.',
            leading: Assets.icons.services1,
          ),
          ServiceCard(
            title: 'Онлайн калькулятор оценки вероятности нарушений',
            subtitle:
                'Пройдите опрос и получите набор рекомендаций для устранения возможных нарушений при использовании земельного участка',
            leading: Assets.icons.services1,
          ),
          ServiceCard(
            title: 'Жалоба на нарушение моратория на проверки',
            subtitle:
                'Если в отношении вас проведена или проводится проверка, нарушающая условия моратория, вы можете подать жалобу. Жалоба рассматривается в течение одного рабочего дня',
            leading: Assets.icons.services1,
          ),
          ServiceCard(
            title: 'Консультирование',
            subtitle:
                'С помощью данной услуги Вы можете проконсультироваться с контрольными (надзорными) органами для уточнения интересующей Вас информации по выбранным темам консультирования',
            leading: Assets.icons.services1,
          ),
          ServiceCard(
            title: 'Ходатайство об отсрочке исполнения решения',
            subtitle:
                'При наличии обстоятельств, препятствующих своевременному исполнению решения органа контроля, вы можете направить ходатайство о продлении срока его исполнения',
            leading: Assets.icons.services1,
          ),
        ],
      ),
    );
  }
}
