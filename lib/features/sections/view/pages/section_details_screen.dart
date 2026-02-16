import 'package:belahododdashboard/features/products/view/pages/modify_product/modify_product_screen.dart';
import 'package:belahododdashboard/features/products/view/pages/modify_product/modify_stationery_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/constants/style/color_style_features.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../core/components/most_used_button.dart';
import '../../../../presentation/view/global_interface.dart';
import '../../../products/view/pages/modify_product/modify_book_screen.dart';
import '../../../products/view/pages/modify_product/modify_game_screen.dart';
import '../../../products/view/pages/modify_product/modify_quran_screen.dart';
import '../../../products/view/widgets/products_section.dart';
import '../../../subsections/view/pages/modify_subsection_screen.dart';
import '../../../subsections/view/widgets/subsections_section.dart';

class SectionDetailsScreen extends StatefulWidget {
  final int? sectionId;
  final int? initialPage;

  const SectionDetailsScreen({super.key, this.sectionId, this.initialPage});

  @override
  State<SectionDetailsScreen> createState() => _SectionDetailsScreenState();
}

class _SectionDetailsScreenState extends State<SectionDetailsScreen> {
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
              height: 10.h,
              width: ((100.w) - 280),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _pageController.jumpToPage(0);
                    },
                    child: Container(
                        width: (50.w - 200),
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
                          "المنتجات",
                          style: TextStyle(
                              fontSize: 25.px,
                              color: _selectedIndex == 0
                                  ? ColorStyleFeatures.headLinesTextColor
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ))),
                  ),
                  VerticalDivider(
                    width: 0.5.w,
                    color: Colors.black,
                    thickness: 0.5.w,
                  ),
                  GestureDetector(
                      onTap: () {
                        _pageController.jumpToPage(1);
                      },
                      child: Container(
                          width: (50.w - 200),
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
                            "الأقسام الفرعية",
                            style: TextStyle(
                                fontSize: 25.px,
                                color: _selectedIndex == 1
                                    ? ColorStyleFeatures.headLinesTextColor
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          ))))
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _selectedIndex = index);
                },
                children: <Widget>[
                  ProductsSection(
                    sectionId: widget.sectionId ?? 0,
                  ),
                  SubsectionsSection(
                    sectionId: widget.sectionId ?? 0,
                  )
                  // RegisterTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(
      MostUsedButton(
        buttonText: _selectedIndex == 0 ? 'إضافة منتج' : 'إضافة قسم فرعي',
        buttonIcon: Icons.add_circle_outline,
        onTap: () {
          if (_selectedIndex == 0) {
            switch (widget.sectionId) {
              case 1:
                Get.to(() => ModifyBookScreen(
                      sectionId: widget.sectionId,
                    ));
                break;
              case 2:
                Get.to(() => ModifyGameScreen(
                      sectionId: widget.sectionId,
                    ));
                break;
              case 3:
                Get.to(() => ModifyStationeryScreen(
                      sectionId: widget.sectionId,
                    ));
                break;

              case 4:
                Get.to(() => ModifyQuranScreen(
                      sectionId: widget.sectionId,
                    ));
                break;
              default:
                Get.to(() => ModifyProductScreen(
                      sectionId: widget.sectionId,
                    ));
                break;
            }
          } else {
            Get.to(() => ModifySubsectionScreen(
                  sectionId: widget.sectionId,
                ));
          }
        },
      ),
    );
    return const GlobalInterface();
  }
}
