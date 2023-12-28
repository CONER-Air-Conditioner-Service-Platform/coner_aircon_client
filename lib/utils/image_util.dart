import 'package:flutter/material.dart';

Widget profileImageWidget(double size, url) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(100),
    child: Container(
      width: size,
      height: size,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/icon_color.png'),
            fit: BoxFit.fitWidth,
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
