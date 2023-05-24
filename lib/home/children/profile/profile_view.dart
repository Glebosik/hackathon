import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/app/app.dart';
import 'package:hackathon/home/children/profile/widgets/widgets.dart';

class ProfileView extends StatelessWidget {
  const ProfileView(
      {super.key, this.firstName, this.secondName, this.thirdName});

  final String? firstName, secondName, thirdName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Column(
      children: [],
    );
  }
}
