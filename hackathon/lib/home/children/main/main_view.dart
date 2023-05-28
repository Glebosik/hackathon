import 'package:flutter/material.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/home/widgets/widgets.dart';
import 'package:hackathon/text_styles.dart';

import 'widgets/widgets.dart';

class MainView extends StatelessWidget {
  const MainView({
    super.key,
    required this.bottomKey,
  });

  final Key bottomKey;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Assets.icons.logoName.svg(height: 48),
        actions: <Widget>[
          IconButton(
            splashRadius: 24,
            icon: Assets.icons.search.svg(),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              SizedBox(height: height * 0.18, child: const ResourcesListView()),
              const SizedBox(height: 16),
              const SizedBox(height: 200, child: ServiceList()),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: ConsultButton(),
              ),
              const Spacer(),
              Container(
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 1),
                          blurRadius: 5)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Дополнительные сервисы',
                        style: TextStyles.black16,
                      ),
                      const SizedBox(height: 24),
                      const ServiceButton(
                        text: 'Записаться на приём',
                      ),
                      const SizedBox(height: 16),
                      const ServiceButton(
                          text: 'Электронная приёмная правительства Москвы'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),

      /*ListView(
        children: [
          const SizedBox(height: 32),
          SizedBox(height: height * 0.18, child: const ResourcesListView()),
          const SizedBox(height: 16),
          const SizedBox(height: 32),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: ConsultButton(),
          ),
          const SizedBox(height: 32),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(0, 1), blurRadius: 5)
                ]),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Дополнительные сервисы',
                    style: TextStyles.black16bold,
                  ),
                  const SizedBox(height: 24),
                  const ServiceButton(text: 'Записаться на приём'),
                  const SizedBox(height: 16),
                  const ServiceButton(
                      text: 'Электронная приёмная правительства Москвы'),
                ],
              ),
            ),
          )
        ],
      ),*/
      bottomNavigationBar: HomeBottomNavBar(key: bottomKey),
    );
  }
}
