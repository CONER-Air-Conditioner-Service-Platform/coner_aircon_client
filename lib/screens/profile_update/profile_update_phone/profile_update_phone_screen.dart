import 'package:coner_client/screens/profile_update/profile_update_phone/widgets/profile_update_phone_appbar.dart';
import 'package:coner_client/screens/profile_update/profile_update_phone/widgets/profile_update_phone_form.dart';
import 'package:flutter/material.dart';

class ProfileUpdatePhoneScreen extends StatefulWidget {
  const ProfileUpdatePhoneScreen({super.key});

  @override
  State<ProfileUpdatePhoneScreen> createState() => _ProfileUpdatePhoneScreenState();
}

class _ProfileUpdatePhoneScreenState extends State<ProfileUpdatePhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          ProfileUpdatePhoneAppbar(),
          Expanded(
            child: ProfileUpdatePhoneForm(),
          ),
        ],
      ),
    );
  }
}
