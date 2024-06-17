import 'package:flutter/material.dart';

Widget profileImageWidget(double size, url) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(100),
    child: SizedBox(
      width: size,
      height: size,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/test_image.png'),
            fit: BoxFit.contain,
          ),
        ),
        width: size,
        height: size,
        child: Center(
          child: url == null || url == ''
              ? const SizedBox()
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
