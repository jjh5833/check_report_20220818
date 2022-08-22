import 'dart:io';

import 'package:check_report_20220818/controllers/check_report_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckReportPage extends StatelessWidget {
  CheckReportPage({Key ? key}) : super(key: key);

  final CheckReportPageController checkReportPageController = Get.put(CheckReportPageController());
  final paddingValue = 10;
  final buttonAreaHeight = 40;
  final titleAreaHeight = 40;
  final photoAspectRatio = 1.2;
  final safeAreaHeight = 10;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var areaWidth = screenWidth / 2 - paddingValue * 2;
    var areaHeight = areaWidth * photoAspectRatio + buttonAreaHeight + titleAreaHeight + safeAreaHeight;

    return Scaffold(
        appBar: AppBar(
          title: const Text('시공사진'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('2022.05.10 등촌 SS 양동 DL 보통점검'),
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: checkReportPageController.gridTitle.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: areaWidth / areaHeight,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                height: areaWidth * photoAspectRatio,
                                width: areaWidth,
                                decoration: BoxDecoration(border: Border.all()),
                                child: GetBuilder<CheckReportPageController>(builder: (controller) {
                                  if(controller.getImagePath(index) == '') {
                                    return Container();
                                  } else {
                                    return Image.file(File(controller.getImagePath(index)));
                                  }
                                },),
                              ),
                            ),
                            Row(
                              mainAxisAlignment : MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      print(index.toString());
                                      checkReportPageController.getCameraImage(index);
                                    },
                                    child: Text('카메라'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    checkReportPageController.getGalleryImage(index);
                                  },
                                  child: Text('갤러리'),
                                ),
                              ],
                            ),
                            Text(checkReportPageController.getGridTitle(index)),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
          ),
        ),
      );
  }
}