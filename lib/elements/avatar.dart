import 'package:flutter/material.dart';

class ProjectUserAvatar extends StatefulWidget {
  const ProjectUserAvatar({
    super.key,
    required this.userAvatarLink,
    required this.radius,
  });

  final String userAvatarLink;
  final double radius;

  @override
  State<ProjectUserAvatar> createState() => _ProjectUserAvatarState();
}

class _ProjectUserAvatarState extends State<ProjectUserAvatar> {
  @override
  Widget build(BuildContext context) {
    return
      widget.userAvatarLink.isNotEmpty
          ? CircleAvatar(
        radius: widget.radius,
        backgroundImage: NetworkImage(widget.userAvatarLink),
      )
          : CircleAvatar(
        radius: widget.radius,
        backgroundImage:
        const AssetImage('assets/images/default_profile_avatar.png'),
      );
  }
}
