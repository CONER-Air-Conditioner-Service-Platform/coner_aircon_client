import 'package:flutter/material.dart';

BoxDecoration itemBottomRadiusDecoration = const BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(10),
    bottomRight: Radius.circular(10),
  ),
  boxShadow: [BoxShadow(blurRadius: 2, color: Colors.grey)],
);
