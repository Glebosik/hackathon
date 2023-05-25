import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/app/app.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/children/profile/widgets/card_shimmer.dart';
import 'package:hackathon/home/children/profile/widgets/list_card.dart';
import 'package:hackathon/home/widgets/widgets.dart';
import 'package:hackathon/text_styles.dart';

class ProfileViewShimmer extends StatelessWidget {
  const ProfileViewShimmer({super.key, required this.bottomKey});

  final Key bottomKey;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Column(
        children: [
          CardShimmer(width: width * 0.97, height: height * 0.2),
          SizedBox(height: height * 0.02),
          Expanded(
            child: Column(
              children: [
                //TODO: добавить иконки
                ListCard(
                  title: 'Анкетные данные',
                  icon: Assets.icons.listTask.svg(),
                  height: height * 0.09,
                ),
                ListCard(
                  title: 'Безопасность',
                  icon: Assets.icons.security.svg(),
                  height: height * 0.09,
                ),
                ListCard(
                  title: 'Биометрия',
                  icon: Assets.icons.fingerprint.svg(),
                  height: height * 0.09,
                ),
                ListCard(
                  title: 'Настройка уведомлений',
                  icon: Assets.icons.notification.svg(),
                  height: height * 0.09,
                ),
                ListCard(
                  title: 'Помощь и поддержка',
                  icon: Assets.icons.assistance.svg(),
                  height: height * 0.09,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width * 0.45, height * 0.07),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {},
                        child: Text(
                          'О приложении',
                          style: TextStyles.black14,
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width * 0.45, height * 0.07),
                          backgroundColor: ColorName.backgroundOtherOrange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          context
                              .read<AppBloc>()
                              .add(const AppLogoutRequested());
                        },
                        child: Text(
                          'Выход',
                          style: TextStyles.black14
                              .copyWith(color: ColorName.orange),
                        ))
                  ],
                ),
                const Spacer(),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: HomeBottomNavBar(
        key: bottomKey,
      ),
    );
  }
}
