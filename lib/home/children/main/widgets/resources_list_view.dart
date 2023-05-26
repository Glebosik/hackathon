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
          image: Assets.images.mainList11
              .image(width: width, height: height, fit: BoxFit.cover),
          text: 'Поддержка бизнеса во время пандемии',
          link: 'https://www.mos.ru/city/projects/covid-19/business/',
        ),
        SizedBox(width: width * 0.02),
        TextOverImage(
          image: Assets.images.mainList21
              .image(width: width, height: height, fit: BoxFit.cover),
          text: 'Инвестиционный портал Москвы',
          link: 'https://investmoscow.ru/',
        ),
        SizedBox(width: width * 0.02),
        TextOverImage(
          image: Assets.images.mainList31
              .image(width: width, height: height, fit: BoxFit.cover),
          text: 'Штаб по защите бизнеса',
          link: 'https://shtab.mos.ru/',
        ),
        SizedBox(width: width * 0.02),
        TextOverImage(
          image: Assets.images.mainList41
              .image(width: width, height: height, fit: BoxFit.cover),
          text: 'Портал поставщиков',
          link: 'https://zakupki.mos.ru/',
        ),
        SizedBox(width: width * 0.02),
        TextOverImage(
          image: Assets.images.mainList51
              .image(width: width, height: height, fit: BoxFit.cover),
          text: 'Портал «Малый бизнес Москвы»',
          link: 'https://mbm.mos.ru/',
        ),
        SizedBox(width: width * 0.02),
        TextOverImage(
          image: Assets.images.mainList61
              .image(width: width, height: height, fit: BoxFit.cover),
          text: 'Московский инновационный кластер',
          link: 'https://i.moscow/',
        ),
        SizedBox(width: width * 0.05),
      ],
    );
  }
}
