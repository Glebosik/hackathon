import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, this.photo, this.avatarSize = 24.0});

  final String? photo;
  final double? avatarSize;

  @override
  Widget build(BuildContext context) {
    final photo = this.photo;
    return CircleAvatar(
      radius: avatarSize,
      backgroundImage: photo != null ? NetworkImage(photo) : null,
      child:
          photo == null ? Icon(Icons.person_outline, size: avatarSize) : null,
    );
  }
}
