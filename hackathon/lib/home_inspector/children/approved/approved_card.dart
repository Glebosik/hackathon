import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/home_inspector/bloc/home_inspector_navigation_bloc.dart';
import 'package:hackathon/home_inspector/children/approved/approved_detail_view.dart';
import 'package:hackathon/text_styles.dart';
import 'package:hackathon/utils/route_transitions.dart';

class ApprovedCard extends StatelessWidget {
  const ApprovedCard({
    super.key,
    required this.applicationUser,
    required this.bottomKey,
  });

  final ApplicationUser applicationUser;
  final Key bottomKey;

  @override
  Widget build(BuildContext context) {
    final application = applicationUser.application;
    final width = MediaQuery.of(context).size.width;
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      elevation: 2,
      child: InkWell(
        onTap: () async {
          dynamic result =
              await Navigator.of(context).push(createRoute(ApprovedDetailView(
            bottomKey: bottomKey,
            applicationUser: applicationUser,
          )));
          if (result is String && result == 'Update' && context.mounted) {
            context
                .read<HomeInspectorNavigationBloc>()
                .add(UpdateApprovedAndGoToScreen());
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Запись на ${FreeSlot(application.dateStart, application.dateEnd).toDayMonth()} в ${FreeSlot(application.dateStart, application.dateEnd).toStartTime()}',
                  style: TextStyles.black14
                      .copyWith(color: ColorName.disabledBackground),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'ИП «${applicationUser.user.secondName} ${applicationUser.user.firstName}${applicationUser.user.thirdName != null ? ' ${applicationUser.user.thirdName}' : ''}»',
                style: TextStyles.black14,
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      application.status == 'На рассмотрении'
                          ? Assets.icons.statusWaiting.svg()
                          : Assets.icons.statusApproved.svg(),
                      SizedBox(width: width * 0.02),
                      Flexible(
                        child: Text(
                          application.status,
                          style:
                              TextStyles.black12.copyWith(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.arrow_forward_ios, size: 16)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
