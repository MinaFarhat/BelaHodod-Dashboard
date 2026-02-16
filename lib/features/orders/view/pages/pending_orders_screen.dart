import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/constants/style/color_style_features.dart';
import '../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../presentation/view/global_interface.dart';
import '../widgets/paid_by_transfer_section.dart';
import '../widgets/ordered_now_section.dart';

class PendingOrdersScreen extends StatefulWidget {
  final int? initialPage;

  const PendingOrdersScreen({super.key, this.initialPage});

  @override
  State<PendingOrdersScreen> createState() => _PendingOrdersScreenState();
}

class _PendingOrdersScreenState extends State<PendingOrdersScreen> {
  int _selectedIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    if (widget.initialPage != null) {
      _selectedIndex = widget.initialPage!;
    }
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalInterfaceController globalInterfaceController =
        Get.put(GlobalInterfaceController());
    globalInterfaceController.removeExtraWidgets();

    globalInterfaceController.addExtraWidget(
      Expanded(
          child: Column(
        children: [
          SizedBox(
            height: 30.h,
            child:Expanded(
            child:
            LayoutBuilder(builder: (context, constraint) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pageController.jumpToPage(0);
                    },
                    child: Container(
                      width: constraint.maxWidth * 0.498,
                      height: constraint.maxHeight * 0.2,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey,
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.grey,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "تم طلبها الان",
                          style: TextStyle(
                            fontSize: 25.px,
                            color: _selectedIndex == 0
                                ? ColorStyleFeatures.headLinesTextColor
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraint.maxHeight * 0.2,
                    child: VerticalDivider(
                      width: constraint.maxWidth * 0.0009,
                      color: Colors.black,
                      thickness: 0.3.w,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _pageController.jumpToPage(1);
                    },
                    child: Container(
                      width: constraint.maxWidth * 0.4999,
                      height: constraint.maxHeight * 0.2,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.grey,
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.white,
                            Colors.grey,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "مدفوعة بحوالة",
                          style: TextStyle(
                            fontSize: 25.px,
                            color: _selectedIndex == 1
                                ? ColorStyleFeatures.headLinesTextColor
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),),

          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _selectedIndex = index);
              },
              children: const <Widget>[
                OrderedNowSection(),
                PaidByTransferSection(),
                // RegisterTab(),
              ],
            ),
          )
        ],
      )),
      //),
    );

    return const GlobalInterface();
  }
}
