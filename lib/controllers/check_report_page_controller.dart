import 'dart:io';

import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path/path.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckReportPageController extends GetxController {
  static CheckReportPageController get to => Get.find();

  List<String> gridTitle = ['계폐특성시험', '수분 및 SO2 측정', 'CT절연저항측정', '코일저항측정', '단자 재조임', '판넬청소'];
  List<String> photoFileName = ['', '', '', '', '', ''];

  List<String> imagePath = ['', '', '', '', '', ''];

  String getGridTitle(int index) {
    return gridTitle[index];
  }

  int getGridCount() {
    return gridTitle.length;
  }

  String getPhotoFileName(int index) {
    return photoFileName[index];
  }

  void setPhotoFileName(String name, int index) {
    photoFileName[index] = name;
    update();
  }

  void getCameraImage(int index) async {
    final status = await Permission.storage.status;
    print('카메라 시작');
    if(!status.isGranted) {
      await Permission.storage.request();
    }
    print('카메라 시작1');

    final ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    print('카메라 시작2');

    if(pickedFile != null) {
      var selectedImagePath = pickedFile.path;
      print('카메라 시작3');

      print('selectedImagePath' + selectedImagePath);

      var tempFile = File(selectedImagePath);
      print('카메라 시작4');

      // var result = await GallerySaver.saveImage(selectedImagePath);
      var result = await ImageGallerySaver.saveFile(selectedImagePath);
      // var result = await ImageGallerySaver.saveImage(selectedImagePath);
      print('result');
      print(result);

      var tempPath = result['filePath'];
      print('tempPath');
      print(tempPath);
      print(tempPath.substring(7));

      setImagePath(tempPath.substring(7), index);

      var fileName = basename(selectedImagePath);
      print('fileName');
      print(fileName);
      // var result1 = await tempFile.delete();
      // print('result1');
      // print(result1);

    } else {
      Get.snackbar(
        'Error',
        'No image selected',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void getGalleryImage(int index) async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null) {
      var selectedImagePath = pickedFile.path;

      print('selectedImagePath' + selectedImagePath);

      setImagePath(selectedImagePath, index);

      // var tempFile = File(selectedImagePath);
      //
      // // var result = await GallerySaver.saveImage(selectedImagePath);
      // var result = await ImageGallerySaver.saveFile(selectedImagePath);
      // // var result = await ImageGallerySaver.saveImage(selectedImagePath);
      // print('result');
      // print(result);
      //
      // var tempPath = result['filePath'];
      // print('tempPath');
      // print(tempPath);
      // print(tempPath.substring(7));
      //
      // setImagePath(tempPath.substring(7), index);
      //
      // var fileName = basename(selectedImagePath);
      // print('fileName');
      // print(fileName);
      // // var result1 = await tempFile.delete();
      // // print('result1');
      // // print(result1);
      //
    } else {
      Get.snackbar(
        'Error',
        'No image selected',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  String getImagePath(int index) {
    return imagePath[index];
  }

  void setImagePath(String path, int index) {
    imagePath[index] = path;
    update();
  }
}