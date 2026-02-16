import 'package:belahododdashboard/features/permissions/view/widgets/salesman_users_section.dart';
import 'package:belahododdashboard/features/permissions/view/widgets/sys_users_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/components/most_used_button.dart';
import '../../../../core/constants/style/color_style_features.dart';
import '../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../presentation/view/global_interface.dart';
import 'add_user_screen.dart';

class UsersAccountsScreen extends StatefulWidget {
  final int? initialPage;

  const UsersAccountsScreen({super.key, this.initialPage});

  @override
  State<UsersAccountsScreen> createState() => _UsersAccountsScreenState();
}

class _UsersAccountsScreenState extends State<UsersAccountsScreen> {
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
            child: Expanded(
              child: LayoutBuilder(builder: (context, constraint) {
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
                            " مستخدمي النظام ",
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
                            " مستخدمي الجملة ",
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
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _selectedIndex = index);
              },
              children: const <Widget>[
                SysUsersSection(),
                SalesmanUsersSection(),
                // RegisterTab(),
              ],
            ),
          )
        ],
      )),
    );
    globalInterfaceController.addExtraWidget(
      MostUsedButton(
        buttonText: 'إضافة مستخدم',
        buttonIcon: Icons.add_circle_outline,
        onTap: () {
          Get.to(() => AddUserScreen(sectionId: _selectedIndex));
        },
      ),
    );
    return const GlobalInterface();
  }
}
