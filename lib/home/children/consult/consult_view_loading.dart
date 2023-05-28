import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home/bloc/home_navigation_bloc.dart';
import 'package:hackathon/home/children/check_in/check_in_view.dart';
import 'package:hackathon/home/widgets/widgets.dart';
import 'package:hackathon/text_styles.dart';
import 'package:hackathon/utils/route_transitions.dart';
import 'package:shimmer/shimmer.dart';

class ConsultViewLoading extends StatelessWidget {
  const ConsultViewLoading({super.key, required this.bottomKey});

  final Key bottomKey;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Консультации'),
      ),
      body: Container(),
      floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(width * 0.95, height * 0.07)),
          onPressed: () async {
            final bool done = await Navigator.of(context)
                .push(createRoute(const CheckInView()));
            if (done && context.mounted) {
              context.read<HomeNavigationBloc>().add(UpdateApplications());
            }
          },
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
