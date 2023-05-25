import 'package:flutter/material.dart';
import 'package:hackathon/gen/assets.gen.dart';
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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Assets.icons.logoName.svg(height: 56),
        actions: <Widget>[
          IconButton(
            splashRadius: 24,
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            SizedBox(
              height: height * 0.2,
              width: width,
              child: const ResourcesListView(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: height * 0.3,
              width: width * 0.95,
              child: const ServiceList(),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: width * 0.9,
              child: const ConsultButton(),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: width,
              child: Container(
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
              ),
            )
          ],
        ),
      )),
      bottomNavigationBar: HomeBottomNavBar(key: bottomKey),
    );
  }
}
