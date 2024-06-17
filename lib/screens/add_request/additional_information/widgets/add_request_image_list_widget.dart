import 'dart:io';

import 'package:coner_client/configs/router/route_names.dart';
import 'package:coner_client/provider/request_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_text_styles.dart';

class AddRequestImageListWidget extends StatelessWidget {
  const AddRequestImageListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("추가 관련 사진(선택)", style: AppTextStyles.s1Bold),
            GestureDetector(
              onTap: () => context.pushNamed(RouteNames.requestExampleImage),
              child: Text("예시 보기", style: AppTextStyles.b1BoldUnderline),
            ),
          ],
        ),
        Text("예시와 같은 사진을 등록하시면 서비스 제공이 빨라질 수 있어요.", style: AppTextStyles.c1Grey),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < requestProvider.requestImageFileList.length; i++)
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: ((context) {
                        return Dialog(
                          child: Container(
                            width: 300,
                            height: 148,
                            padding: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                color: Colors.white, borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 8),
                                      Text('이미지를 삭제하시겠습니까?', style: AppTextStyles.b2),
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
                                                borderRadius: const BorderRadius.only(
                                                    bottomLeft: Radius.circular(10)),
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
                                              requestProvider.removeRequestImage(i);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.coner2,
                                                borderRadius: const BorderRadius.only(
                                                    bottomRight: Radius.circular(10)),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text('삭제', style: AppTextStyles.b2BoldWhite),
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
                  },
                  child: _imageHelper(requestProvider.requestImageFileList[i]!),
                ),
              InkWell(
                onTap: () => requestProvider.addRequestImage(),
                child: Container(
                  width: 150,
                  height: 150,
                  color: AppColors.grey3,
                  alignment: Alignment.center,
                  child: const Icon(Icons.add, size: 24, color: Colors.black),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.info_outline_rounded, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text("사진을 터치하면 삭제할 수 있어요!", style: AppTextStyles.c1Grey),
          ],
        )
      ],
    );
  }

  Widget _imageHelper(File url) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Image.file(File(url.path), fit: BoxFit.fitHeight, height: 150),
    );
  }
}
