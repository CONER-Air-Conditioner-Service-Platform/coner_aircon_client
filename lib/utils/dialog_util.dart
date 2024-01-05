import 'package:coner_client/theme/colors.dart';
import 'package:coner_client/theme/font_styles.dart';
import 'package:flutter/material.dart';

void signInDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
    builder: ((context) {
      return Dialog(
        child: Container(
          width: 300,
          height: 148,
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Text('코너를 이용하시려면', style: body2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('로그인이 필요', style: body2Bold),
                        Text('해요!', style: body2),
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
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: conerGrey,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
                            ),
                            alignment: Alignment.center,
                            child: Text('둘러보기', style: body2BoldWhite),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: conerColor2,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                            ),
                            alignment: Alignment.center,
                            child: Text('로그인', style: body2BoldWhite),
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
