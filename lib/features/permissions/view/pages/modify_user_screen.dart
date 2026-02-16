// ignore_for_file: avoid_print

import 'package:belahododdashboard/features/authentication/model/models/wholesale_user_model.dart';
import 'package:belahododdashboard/features/authentication/model/params/users_params.dart';
import 'package:belahododdashboard/features/permissions/controller/roles_controller.dart';
import 'package:belahododdashboard/features/permissions/controller/users_controller.dart';
import 'package:belahododdashboard/features/permissions/model/params/role_params.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/components/custom_dropdown_list.dart';
import '../../../../core/components/used_filled.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';

import '../../../../presentation/controllers/global_interface_controller.dart';

import '../../../../core/components/most_used_button.dart';

import '../../../../presentation/view/global_interface.dart';
import '../../../subsections/controller/dropdown_controller.dart';

class ModifyUserScreen extends StatefulWidget {
  final WholesaleUserModel? user;

  const ModifyUserScreen({super.key, this.user});

  @override
  State<ModifyUserScreen> createState() => _ModifyUserScreenState();
}

class _ModifyUserScreenState extends State<ModifyUserScreen> {
  int? rolesNumber = 0;

  final UsersController? usersController = Get.put(UsersController());
  final _userFormKey = GlobalKey<FormState>();
  UsersParams params = UsersParams();
  RoleParams roleParams = RoleParams();
  final RolesController? rolesController = Get.find<RolesController>();
  final DropdownController? dropdownController = Get.find<DropdownController>();

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  void initState() {
    if (widget.user != null) {
      name.text = widget.user?.name ?? "";
      password.text = "";
      phoneNumber.text = widget.user?.phoneNumber ?? "";
    }
    rolesController?.getRoles(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalInterfaceController globalInterfaceController =
        Get.put(GlobalInterfaceController());
    globalInterfaceController.removeExtraWidgets();
    globalInterfaceController.addExtraWidget(
      Center(
        child: Text(
          'تعديل حساب',
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );
    globalInterfaceController.addExtraWidget(Form(
      key: _userFormKey,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UsedFilled(
              label: 'اسم المستخدم',
              controller: name,
              isMandatory: true,
              onSaved: (value) {
                params.name = value;
              },
            ),
            UsedFilled(
              label: ' كلمة السر',
              controller: password,
              isMandatory: true,
              onSaved: (value) {
                params.password = value;
              },
            ),
            UsedFilled(
              label: 'رقم الهاتف',
              controller: phoneNumber,
              isMandatory: true,
              onSaved: (value) {
                params.phoneNumber = value;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "الدور المسند للحساب",
                  style: TextStyleFeatures.generalTextStyle,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  widget.user!.roleName.toString(),
                  style: const TextStyle(fontSize: 25, color: Colors.blueGrey),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(.5),
              child: rolesController!.obx((state) {
                var subsections = state ?? [];
                var itemNames = subsections.map((item) => item.name).toList();
                var selectedItem =
                    dropdownController?.selectedStringItems.value;

                // Ensure selectedItem is in the list
                if (selectedItem != null && !itemNames.contains(selectedItem)) {
                  selectedItem = null; // Reset if invalid
                }

                return CustomDropdownList(
                  hint: "تعديل الدور",
                  label: " الأدوار",
                  onChanged: (value) {
                    // Update the selected string
                    dropdownController?.sChange(value);

                    // Find and update the corresponding ID
                    var selectedSubSection =
                        subsections.firstWhere((item) => item.name == value);
                    dropdownController?.setSubSectionId(selectedSubSection.id);
                    rolesNumber = subsections.length;
                  },
                  sItems: List<DropdownMenuItem<String>>.generate(
                    subsections.length,
                    (index) {
                      return DropdownMenuItem<String>(
                        value: subsections[index].name,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            '${subsections[index].name}',
                            style: TextStyle(fontSize: 18.px),
                          ),
                        ),
                      );
                    },
                  ),
                  selectedItem: selectedItem,
                );
              }),
            ),
          ],
        ),
      ),
    ));

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(
      MostUsedButton(
        buttonText: 'حفظ',
        buttonIcon: Icons.save,
        onTap: () {
          if (_userFormKey.currentState!.validate()) {
            if (rolesNumber != 0) {
              print(
                  "roleId: ${dropdownController?.selectedSubSectionId.value.toString()}");
              roleParams.roleId =
                  dropdownController?.selectedSubSectionId.value.toString();
              usersController?.updateUserRole(widget.user?.id ?? 0, roleParams);
            }
            _userFormKey.currentState?.save();

            if (widget.user != null) {
              usersController?.updateUser(widget.user?.id ?? 0, params);
            } else {
              //usersController?.addUser(params);
            }
          }
        },
      ),
    );
    return const GlobalInterface();
  }
}
