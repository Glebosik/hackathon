import 'package:flutter/material.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/widgets/widgets.dart';
import 'package:hackathon/text_styles.dart';

class ConsultView extends StatelessWidget {
  const ConsultView({super.key, required this.bottomKey});

  final Key bottomKey;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Консультации'),
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
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Ваши записи',
                    style: TextStyles.black18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    elevation: 0,
                    color: ColorName.backgroundOrange,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Запись на 21.06 в 11:30',
                              style: TextStyles.black14
                                  .copyWith(color: ColorName.hyperlinkOrange),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'ДЕПАРТАМЕНТ ТРАНСПОРТА И РАЗВИТИЯ ДОРОЖНО-ТРАНСПОРТНОЙ ИНФРАСТРУКТУРЫ ГОРОДА МОСКВЫ',
                            style: TextStyles.black14,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Assets.icons.statusWaiting.svg(),
                              SizedBox(width: width * 0.02),
                              Flexible(
                                  child: Text(
                                'на рассмотрении',
                                style: TextStyles.black12
                                    .copyWith(color: Colors.grey),
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(width * 0.95, height * 0.07)),
          onPressed: () {},
          child: Text(
            'Записаться на консультирование',
            style: TextStyles.white16,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: HomeBottomNavBar(
        key: bottomKey,
      ),
    );
  }
}
