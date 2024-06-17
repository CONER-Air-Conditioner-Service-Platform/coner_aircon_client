import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CameraPackage {
  static Future<File?> getImage(List<File?> images) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    File? img = File(image!.path);
    img = await cropImage(img);
    if (img != null) {
      return img;
    }
    return null;
  }

  static Future<List<File>> getImages(List<File?> images) async {
    final images = await ImagePicker().pickMultiImage();
    List<File> imgs = [];
    for (XFile image in images) {
      imgs.add(File(image.path));
    }
    return imgs;
  }

  static Future<List<File>> getImagesWithCrop(List<File?> images) async {
    final images = await ImagePicker().pickMultiImage();
    List<File> imgs = [];
    for (XFile image in images) {
      imgs.add(File(image.path));
    }
    imgs = await cropImages(imgs);
    return imgs;
  }

  static Future cropImage(File imageFile) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  static Future cropImages(List<File?> images) async {
    List<File> croppedImages = [];
    for (File? image in images) {
      CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: image!.path,
        aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
      );
      croppedImages.add(File(croppedImage!.path));
    }
    return croppedImages;
  }

  static Widget imageHelper(url) {
    return SizedBox(
      height: 150,
      width: 200,
      child: Image.file(File(url!.path), fit: BoxFit.fill),
    );
  }
}
