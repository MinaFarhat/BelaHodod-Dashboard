import 'package:belahododdashboard/features/authentication/controller/user_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/components/custom_side_bar.dart';
import '../controllers/global_interface_controller.dart';
import '../../core/components/custom_app_bar.dart';

class GlobalInterface extends StatefulWidget {
  const GlobalInterface({super.key});

  @override
  State<GlobalInterface> createState() => _GlobalInterfaceState();
}

class _GlobalInterfaceState extends State<GlobalInterface> {
  @override
  void initState() {
    super.initState();
    Get.put(
        UserInfoController()); // Puts UserInfoController when this widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Row(
          children: [
            Flexible(
              flex: 2,
              child: Obx(() {
                return CustomSidebar(
                  dropdowns: Get.find<GlobalInterfaceController>().dropdowns,
                  loggedInUser: UserInfoController.uName.value ?? "",
                );
              }),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(),
                    ...Get.put(GlobalInterfaceController()).extraWidgets,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
