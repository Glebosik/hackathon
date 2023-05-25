import 'package:flutter/material.dart';
import 'package:hackathon/text_styles.dart';

class ListCard extends StatelessWidget {
  const ListCard(
      {super.key,
      this.onTap,
      required this.title,
      required this.icon,
      required this.height});

  final void Function()? onTap;
  final String title;
  final Widget icon;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width * 0.97,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        child: InkWell(
          onTap: onTap ?? () {},
          child: Center(
            child: ListTile(
              leading: icon,
              title: Text(
                title,
                style: TextStyles.black16,
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
