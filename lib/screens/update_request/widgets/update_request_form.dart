import 'package:coner_client/provider/request_provider.dart';
import 'package:coner_client/screens/add_request/aircon_selection/widgets/aircon_selection_widget.dart';
import 'package:coner_client/screens/add_request/aircon_selection/widgets/brand_selection_widget.dart';
import 'package:coner_client/screens/add_request/time_pick/widgets/time_widget.dart';
import 'package:coner_client/screens/update_request/widgets/service_selection_widget.dart';
import 'package:coner_client/screens/widgets/app_loading_widget.dart';
import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../provider/client_provider.dart';
import '../../../theme/app_decorations.dart';
import '../../../utils/dialog_util.dart';
import '../../add_request/additional_information/widgets/add_request_image_list_widget.dart';
import '../../add_request/additional_information/widgets/detail_info_widget.dart';
import '../../add_request/client_info/widgets/my_info_widget.dart';
import '../../add_request/time_pick/widgets/calendar_widget.dart';

class UpdateRequestForm extends StatefulWidget {
  UpdateRequestForm({super.key});

  @override
  State<UpdateRequestForm> createState() => _UpdateRequestFormState();
}

class _UpdateRequestFormState extends State<UpdateRequestForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController serviceDetailsController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final requestProvider = Provider.of<RequestProvider>(context, listen: false);
      serviceDetailsController = TextEditingController(text: requestProvider.detailInfo);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    serviceDetailsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    final requestProvider = Provider.of<RequestProvider>(context);
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CalendarWidget(),
            const TimeWidget(),
            ServiceSelectionWidget(),
            AirconSelectionWidget(),
            BrandSelectionWidget(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: const MyInfoWidget(),
            ),
            if (requestProvider.service == "수리") ...[
              const DetailInfoWidget(),
            ],
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("요청사항", style: AppTextStyles.s1Bold),
                  const SizedBox(height: 8),
                  Form(key: _formKey, child: _serviceDetailedHelper()),
                  const SizedBox(height: 20),
                  const AddRequestImageListWidget(),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("의뢰서 수정은 기사님 배정 전까지만 가능합니다.", style: AppTextStyles.b2),
                  Text("의뢰하시겠습니까?", style: AppTextStyles.b2Bold),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 52,
                    decoration: AppDecorations.buttonDecoration(const Color(0xffD9D9D9)),
                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () => context.pop(),
                      child: Text('취소', style: AppTextStyles.s1BoldWhite),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 52,
                    decoration: AppDecorations.gradientButtonDecoration,
                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (clientProvider.clientId == '') {
                          DialogUtil.logInDialog(context);
                          return;
                        }
                        AppLoadingWidget.loadingRequest(context);
                        bool isSuccess = await requestProvider.update(
                          context,
                          clientProvider.clientPhoneNumber,
                          clientProvider.clientAddress,
                          clientProvider.clientDetailAddress,
                          serviceDetailsController.text,
                          clientProvider.clientId,
                        );
                        Navigator.pop(context);
                        if (isSuccess) {
                          context.pop();
                        }
                      },
                      child: Text('의뢰하기', style: AppTextStyles.s1BoldWhite),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _serviceDetailedHelper() => TextFormField(
        autofocus: false,
        validator: (value) {
          if (value.toString().isEmpty) {
            return '추가적인 정보와 요청사항을 입력해주세요.';
          } else {
            return null;
          }
        },
        minLines: 6,
        maxLines: 6,
        controller: serviceDetailsController,
      );
}
