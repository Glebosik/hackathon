import 'package:flutter/material.dart';
import 'package:hackathon/gen/assets.gen.dart';

import 'widgets.dart';

class ResourcesListView extends StatelessWidget {
  const ResourcesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        SizedBox(width: width * 0.05),
        TextOverImage(
          image: Assets.images.mainList1
              .image(width: width, height: height, fit: BoxFit.fill),
          text: 'Поддержка бизнеса во время пандемии',
          link: 'https://www.mos.ru/city/projects/covid-19/business/',
        ),
        SizedBox(width: width * 0.02),
        TextOverImage(
          image: Assets.images.mainList2
              .image(width: width, height: height, fit: BoxFit.fill),
          text: 'Инвестиционный портал Москвы',
          link: 'https://investmoscow.ru/',
        ),
        SizedBox(width: width * 0.02),
        TextOverImage(
          image: Assets.images.mainList3
              .image(width: width, height: height, fit: BoxFit.fill),
          text: 'Штаб по защите бизнеса',
          link: 'https://shtab.mos.ru/',
        ),
        SizedBox(width: width * 0.02),
        TextOverImage(
          image: Assets.images.mainList4
              .image(width: width, height: height, fit: BoxFit.fill),
          text: 'Портал поставщиков',
          link: 'https://zakupki.mos.ru/',
        ),
        SizedBox(width: width * 0.02),
        TextOverImage(
          image: Assets.images.mainList5
              .image(width: width, height: height, fit: BoxFit.fill),
          text: 'Портал «Малый бизнес Москвы»',
          link: 'https://mbm.mos.ru/',
        ),
        SizedBox(width: width * 0.02),
        TextOverImage(
          image: Assets.images.mainList6
              .image(width: width, height: height, fit: BoxFit.fill),
          text: 'Московский инновационный кластер',
          link: 'https://i.moscow/',
        ),
        SizedBox(width: width * 0.05),
      ],
    );
  }
}
