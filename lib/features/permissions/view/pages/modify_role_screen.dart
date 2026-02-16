import 'package:belahododdashboard/features/permissions/controller/permissions_controller.dart';
import 'package:belahododdashboard/features/permissions/model/models/role_model.dart';
import 'package:belahododdashboard/features/permissions/model/params/permission_params.dart';
import 'package:belahododdashboard/features/permissions/model/params/role_params.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/components/custom_dropdown_list.dart';
import '../../../../core/components/retry_widget.dart';
import '../../../../core/components/used_filled.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';
import '../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../core/components/most_used_button.dart';
import '../../../../presentation/view/global_interface.dart';
import '../../controller/role_state_controller.dart';
import '../../controller/roles_controller.dart';

class ModifyRoleScreen extends StatefulWidget {
  final PermessionModel? role;

  const ModifyRoleScreen({super.key, this.role});

  @override
  State<ModifyRoleScreen> createState() => _ModifyRoleScreenState();
}

class _ModifyRoleScreenState extends State<ModifyRoleScreen> {
  final RolesController? rolesController = Get.find<RolesController>();
  final PermissionsController? permissionsController =
      Get.find<PermissionsController>();
  final _roleFormKey = GlobalKey<FormState>();
  RoleParams params = RoleParams();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  List<PermissionParams> permissionsParams = [];
  final RoleStateController roleStateController =
      Get.put(RoleStateController());

  @override
  void initState() {
    permissionsParams = [];
    roleStateController.clear();

    rolesController?.getRolePermissions(true, widget.role?.id ?? -1);
    permissionsController?.getAllPermissions(
      true,
    );
    if (widget.role != null) {
      name.text = widget.role?.name ?? "";
      description.text = widget.role?.description ?? "";
    }

    super.initState();
  }

  PermessionModel permessionModel = PermessionModel();

  @override
  Widget build(BuildContext context) {
    final GlobalInterfaceController globalInterfaceController =
        Get.put(GlobalInterfaceController());
    globalInterfaceController.removeExtraWidgets();
    globalInterfaceController.addExtraWidget(
      Center(
        child: Text(
          widget.role != null ? 'تعديل دور' : 'إضافة دور جديد',
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );
    globalInterfaceController.addExtraWidget(Form(
      key: _roleFormKey,
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UsedFilled(
                label: 'اسم الدور',
                controller: name,
                isMandatory: true,
                onSaved: (value) {
                  params.name = value;
                },
              ),
              UsedFilled(
                label: 'وصف الدور',
                controller: description,
                isMandatory: true,
                onSaved: (value) {
                  params.description = value;
                },
              ),
              if (widget.role != null)
                Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "الصلاحيات الحالية للدور",
                      style: TextStyleFeatures.generalTextStyle,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ListView.builder(
                      itemCount: permissionsParams.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Text(
                          permissionsParams[index].name ?? "",
                          style: const TextStyle(
                              fontSize: 25, color: Color(0xFF26B7B8)),
                        );
                      },
                    ),
                    rolesController!.obx(
                        (state) => ListView.builder(
                              itemCount: state?.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Text(
                                  state?[index].name ?? "",
                                  style: const TextStyle(
                                      fontSize: 25, color: Color(0xFF26B7B8)),
                                );
                              },
                            ),
                        onLoading:
                            const Center(child: CircularProgressIndicator()),
                        onEmpty: Center(
                          child: RetryWidget(
                              error: "لا يوجد نتائج",
                              func: () => rolesController?.getRolePermissions(
                                  true, widget.role?.id ?? -1)),
                        ),
                        onError: (error) => Center(
                              child: RetryWidget(
                                  error: error!,
                                  func: () =>
                                      rolesController?.getRolePermissions(
                                          true, widget.role?.id ?? -1)),
                            )),
                    SizedBox(
                      height: 3.h,
                    ),
                    permissionsController!.obx(
                        (state) => CustomDropdownList(
                              hint: "الصلاحيات",
                              label: "إضافة صلاحيات",
                              onChanged: (value) {
                                setState(() {
                                  if (permissionsParams.indexWhere(
                                          (x) => x.id == value.id) ==
                                      -1) {
                                    permissionsParams.add(value);
                                    roleStateController.addPermission(value);
                                  }
                                });
                              },
                              dItems: List<
                                  DropdownMenuItem<PermissionParams>>.generate(
                                state!.length,
                                (index) {
                                  return DropdownMenuItem<PermissionParams>(
                                    value: PermissionParams(
                                        id: state[index].id.toString(),
                                        name: state[index].name),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Text(
                                        '${state[index].name}',
                                        style: TextStyle(fontSize: 18.px),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              selectedItem: null,
                            ),
                        onLoading:
                            const Center(child: CircularProgressIndicator()),
                        onEmpty: Center(
                          child: RetryWidget(
                              error: "لا يوجد نتائج",
                              func: () =>
                                  rolesController?.getAllPermissions(true)),
                        ),
                        onError: (error) => Center(
                              child: RetryWidget(
                                  error: error!,
                                  func: () =>
                                      rolesController?.getAllPermissions(true)),
                            )),
                    Obx(() => SingleChildScrollView(
                          child: ListView.builder(
                            //  physics: NeverScrollableScrollPhysics(), // Disable the inner ListView's scroll physics
                            shrinkWrap: true,
                            // Allow the ListView to shrink wrap its height to its content
                            itemCount: roleStateController.permissions.length,
                            itemBuilder: (context, index) {
                              return Text(
                                roleStateController.permissions[index].name,
                                style: const TextStyle(
                                    fontSize: 25, color: Color(0xFF26B7B8)),
                              );
                            },
                          ),
                        )),
                  ],
                )
            ],
          ),
        ),
      ),
    ));

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // MostUsedButton(
          //   buttonText: 'حفظ المعلومات',
          //   buttonIcon: Icons.save,
          //   onTap: () {
          //     if (_roleFormKey.currentState!.validate()) {
          //       _roleFormKey.currentState?.save();
          //
          //
          //       if (widget.role != null) {
          //         rolesController?.updateRole(widget.role?.id ?? 0, params);
          //       } else {
          //         rolesController?.addRole(params);
          //       }
          //     }
          //   },
          // ),
          // if (widget.role != null)
          MostUsedButton(
            buttonText: 'حفظ الأدوار',
            buttonIcon: Icons.save,
            onTap: () {
              if (_roleFormKey.currentState!.validate()) {
                _roleFormKey.currentState?.save();

                if (widget.role != null) {
                  rolesController?.updateRole(widget.role?.id ?? 0, params);

                  rolesController?.addPermissionsToRole(
                      permissionsParams, widget.role?.id ?? 0);
                } else {
                  rolesController?.addRole(params);
                }
              }
            },
          ),
        ],
      ),
    );
    return const GlobalInterface();
  }
}
