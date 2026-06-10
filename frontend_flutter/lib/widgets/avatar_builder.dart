// lib/widgets/avatar_builder.dart
import 'package:flutter/material.dart';

Widget buildAvatar(String avatarPath, {double radius = 40}) {
  if (avatarPath.startsWith('http://') || avatarPath.startsWith('https://')) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFFEFF4FF),
      backgroundImage: NetworkImage(avatarPath), 
    );
  }

  return CircleAvatar(
    radius: radius,
    backgroundImage: const AssetImage('assets/default_profile.png'),
  );
}