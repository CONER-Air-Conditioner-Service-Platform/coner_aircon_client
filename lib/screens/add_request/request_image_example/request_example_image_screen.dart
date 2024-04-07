import 'package:coner_client/screens/add_request/request_image_example/widgets/request_example_image_appbar.dart';
import 'package:coner_client/theme/app_assets.dart';
import 'package:flutter/material.dart';

import '../../../theme/app_text_styles.dart';

class RequestExampleImageScreen extends StatelessWidget {
  const RequestExampleImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const RequestExampleImageAppbar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('1. 에어컨 명판', style: AppTextStyles.h2Bold),
                    const SizedBox(height: 8),
                    Image.asset(AppAssets.requestExampleImage1),
                    const SizedBox(height: 12),
                    Text('2. 에어컨 실내기', style: AppTextStyles.h2Bold),
                    const SizedBox(height: 8),
                    Image.asset(AppAssets.requestExampleImage2),
                    const SizedBox(height: 12),
                    Text('3. 에어컨 실외기', style: AppTextStyles.h2Bold),
                    const SizedBox(height: 8),
                    Image.asset(AppAssets.requestExampleImage3),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
