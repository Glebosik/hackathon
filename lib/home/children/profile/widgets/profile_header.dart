import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/app/app.dart';
import 'package:hackathon/text_styles.dart';

import 'widgets.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.user,
    required this.height,
  });

  final User user;
  final double height;

  @override
  Widget build(BuildContext context) {
    final userAuth = context.select((AppBloc bloc) => bloc.state.user);
    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width * 0.97,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Avatar(
                        photo: userAuth.photo,
                        avatarSize: 24,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.secondName ?? '',
                              style: TextStyles.black18bold),
                          Text(
                              '${user.firstName ?? ''} ${user.thirdName ?? ''}',
                              style: TextStyles.black18bold),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 60),
                      user.approved
                          ? const Icon(Icons.check,
                              color: Colors.green) //TODO: поменять иконки
                          : const Icon(Icons.check_box_outline_blank),
                      user.approved
                          ? Text('учетная запись подтверждена',
                              style: TextStyles.black10)
                          : Text('подтвердите учетную запись',
                              style: TextStyles.black10),
                    ],
                  )
                ],
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
