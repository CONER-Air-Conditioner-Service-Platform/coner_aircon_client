import 'package:coner_client/configs/router/route_names.dart';
import 'package:coner_client/theme/app_colors.dart';
import 'package:coner_client/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../provider/client_provider.dart';
import '../screens/widgets/app_loading_widget.dart';

class DialogUtil {
  static void logInDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
      builder: ((context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 148,
            padding: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text('코너를 이용하시려면', style: AppTextStyles.b2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('로그인이 필요', style: AppTextStyles.b2Bold),
                          Text('해요!', style: AppTextStyles.b2),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.grey2,
                                borderRadius:
                                    const BorderRadius.only(bottomLeft: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child: Text('둘러보기', style: AppTextStyles.b2White),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              context.pushNamed(RouteNames.signIn);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.coner2,
                                borderRadius:
                                    const BorderRadius.only(bottomRight: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child: Text('로그인', style: AppTextStyles.b2BoldWhite),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  static void logOutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
      builder: ((context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 148,
            padding: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text('로그아웃하시겠습니까?', style: AppTextStyles.b2),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.grey2,
                                borderRadius:
                                    const BorderRadius.only(bottomLeft: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child: Text('취소', style: AppTextStyles.b2White),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);
                              AppLoadingWidget.loadingClient(context, "로그아웃중입니다.");
                              final clientProvider =
                                  Provider.of<ClientProvider>(context, listen: false);
                              await clientProvider.logout();
                              Navigator.pop(context);
                              context.goNamed(RouteNames.splash);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.coner2,
                                borderRadius:
                                    const BorderRadius.only(bottomRight: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child: Text('로그아웃', style: AppTextStyles.b2BoldWhite),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  static void withdrawalDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
      builder: ((context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 148,
            padding: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text('정말로 회원탈퇴를 하시겠습니까?', style: AppTextStyles.b2),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.grey2,
                                borderRadius:
                                    const BorderRadius.only(bottomLeft: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child: Text('취소', style: AppTextStyles.b2White),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);
                              AppLoadingWidget.loadingClient(context, "회원탈퇴중입니다.");
                              final clientProvider =
                                  Provider.of<ClientProvider>(context, listen: false);
                              await clientProvider.withdrawal();
                              Navigator.pop(context);
                              context.goNamed(RouteNames.splash);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius:
                                    const BorderRadius.only(bottomRight: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child: Text('회원탈퇴', style: AppTextStyles.b2BoldWhite),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  static void basicDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
      builder: ((context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 148,
            padding: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(content, style: AppTextStyles.b2),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.coner2,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text('닫기', style: AppTextStyles.b2BoldWhite),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
