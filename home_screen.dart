import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:roadmate/worker/wrkr_passwordchange.dart';
import 'package:roadmate/worker/wrkr_view_profile.dart';
import 'package:roadmate/worker/wrkr_view_review.dart';
import 'package:roadmate/worker_home/core/app_color.dart';
import 'package:roadmate/worker_home/core/app_data.dart';
import 'package:roadmate/worker_home/src/view/screen/profile_screen.dart';
import 'package:roadmate/worker_home/src/controller/office_furniture_controller.dart';
import 'package:roadmate/worker_home/src/view/screen/office_furniture_list_screen.dart';

final OfficeFurnitureController1 controller =
    Get.put(OfficeFurnitureController1());

class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({super.key});

  final List<Widget> screens = const [
    OfficeFurnitureListScreen1(),
    passwordechangew(title:'Password'),
    wrkr_view_review(title: 'Rating'),
    worker_profile(title: '',)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            currentIndex: controller.currentBottomNavItemIndex.value,
            showUnselectedLabels: true,
            onTap: controller.switchBetweenBottomNavigationItems,
            fixedColor: AppColor.lightBlack,
            items: AppData.bottomNavigationItems
                .map(
                  (element) => BottomNavigationBarItem(
                      icon: element.icon, label: element.label),
                )
                .toList(),
          );
        },
      ),
      body: Obx(() => screens[controller.currentBottomNavItemIndex.value]),
    );
  }
}
