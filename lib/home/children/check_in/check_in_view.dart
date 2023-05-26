import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/home/children/check_in/bloc/check_in_bloc.dart';
import 'package:hackathon/home/children/check_in/widgets/check_in_body.dart';
import 'package:hackathon/home/children/check_in/widgets/check_in_body_loading.dart';

class CheckInView extends StatelessWidget {
  const CheckInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      builder: (context, state) {
        if (state is CheckKnoLoading) {
          return CheckInBodyLoading();
        } else if (state is CheckInKnoLoaded) {
          return CheckInBody(knos: state.knos);
        } else if (state is CheckKnoLoadingFail) {}
        return const Center(child: Text('pizdyau'));
      },
    );
  }
}
