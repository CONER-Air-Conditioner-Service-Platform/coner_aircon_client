import 'package:flutter/material.dart';

import '../theme/colors.dart';

Widget profileImageWidget(double size, url) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(100),
    child: Container(
      width: size,
      height: size,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [conerColor1, conerColor2, conerColor3],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(100),
          image: const DecorationImage(
            image: AssetImage("assets/images/icon_white.png"),
            fit: BoxFit.contain,
          ),
        ),
        width: size,
        height: size,
        child: Center(
          child: url == null || url == ''
              ? SizedBox()
              : Image.network(
                  url,
                  loadingBuilder:
                      (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  width: size,
                  fit: BoxFit.fill,
                ),
        ),
      ),
    ),
  );
}
