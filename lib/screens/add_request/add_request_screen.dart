import 'package:coner_client/screens/add_request/widget/add_reqeust_appbar_widget.dart';
import 'package:coner_client/screens/add_request/widget/add_request_form.dart';
import 'package:flutter/material.dart';

class AddRequestScreen extends StatelessWidget {
  AddRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AddRequestAppbarWidget(),
          AddRequestForm(),
        ],
      ),
    );
  }
}
