import 'package:coner_client/screens/profile_update/widgets/profile_update_appbar.dart';
import 'package:coner_client/screens/profile_update/widgets/profile_update_form.dart';
import 'package:flutter/material.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          ProfileUpdateAppbar(),
          Expanded(
            child: SingleChildScrollView(
              child: ProfileUpdateForm(),
            ),
          ),
        ],
      ),
    );
  }
}
