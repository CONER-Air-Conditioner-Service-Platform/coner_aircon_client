import 'package:coner_client/screens/update_request/widgets/update_reqeust_appbar_widget.dart';
import 'package:coner_client/screens/update_request/widgets/update_request_form.dart';
import 'package:flutter/material.dart';

class UpdateRequestScreen extends StatelessWidget {
  UpdateRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UpdateRequestAppbarWidget(),
          UpdateRequestForm(),
        ],
      ),
    );
  }
}
