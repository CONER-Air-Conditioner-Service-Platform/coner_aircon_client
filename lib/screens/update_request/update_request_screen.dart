import 'package:coner_client/screens/update_request/widgets/update_reqeust_appbar_widget.dart';
import 'package:coner_client/screens/update_request/widgets/update_request_form.dart';
import 'package:flutter/material.dart';

class UpdateRequestScreen extends StatelessWidget {
  const UpdateRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UpdateRequestAppbarWidget(),
            UpdateRequestForm(),
          ],
        ),
      ),
    );
  }
}
