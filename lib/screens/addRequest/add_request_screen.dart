import 'package:coner_client/screens/addRequest/widget/add_request_form.dart';
import 'package:flutter/material.dart';

import '../addRequest/widget/add_reqeust_appbar_widget.dart';

class AddRequestScreen extends StatelessWidget {
  const AddRequestScreen({super.key});

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
