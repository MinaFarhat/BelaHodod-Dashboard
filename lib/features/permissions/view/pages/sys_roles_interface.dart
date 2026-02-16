import 'package:belahododdashboard/features/permissions/controller/roles_controller.dart';
import 'package:belahododdashboard/features/permissions/view/pages/modify_role_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/components/edit_button.dart';
import '../../../../core/components/retry_widget.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';
import '../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../core/components/most_used_button.dart';
import '../../model/models/role_model.dart';
import '../../../../presentation/view/global_interface.dart';

class SysRolesInterface extends StatefulWidget {
  const SysRolesInterface({super.key});

  @override
  State<SysRolesInterface> createState() => _SysRolesInterfaceState();
}

class _SysRolesInterfaceState extends State<SysRolesInterface> {
  final RolesController? rolesController = Get.find<RolesController>();

  @override
  void initState() {
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
          'أدوار النظام',
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      Expanded(
        child: rolesController!.obx(
            (state) => Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(),
                  columnWidths: const {
                    //0: FractionColumnWidth(0.35),
                    1: FractionColumnWidth(0.4),
                    2: FractionColumnWidth(0.3),
                    3: FractionColumnWidth(0.3),
                  },
                  children: [
                    const TableRow(
                      children: [
                        /*        TableCell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child: Text('حالة الدور',
                                    style: TextStyle(
                                      fontFamily: 'Arabic',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                          ),
                         */
                        TableCell(
                          child: Center(
                            child: Text('اسم الدور',
                                style: TextStyle(
                                  fontFamily: 'Arabic',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('تعديل الدور',
                                style: TextStyle(
                                  fontFamily: 'Arabic',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text('حذف الدور',
                                style: TextStyle(
                                  fontFamily: 'Arabic',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ],
                    ),
                    ...state!.map((item) {
                      return _buildTableRow(
                        item,
                        CellButton(
                          onTap: () {
                            Get.to(() => ModifyRoleScreen(
                                  role: item,
                                ));
                          },
                          icon: Icons.edit,
                          label: "تعديل",
                        ),
                        CellButton(
                          onTap: () async {
                            bool? isRefresh =
                                await rolesController?.deleteRole(item.id ?? 0);
                            if (isRefresh ?? false) {
                              rolesController?.getAllPermissions(false);
                            }
                          },
                          icon: Icons.delete,
                          label: "حذف",
                        ),
                      );
                    }),
                  ],
                ),
            onLoading: const Center(child: CircularProgressIndicator()),
            onEmpty: Center(
              child: RetryWidget(
                  error: "لا يوجد نتائج",
                  func: () => rolesController?.getAllPermissions(true)),
            ),
            onError: (error) => Center(
                  child: RetryWidget(
                      error: error!,
                      func: () => rolesController?.getAllPermissions(true)),
                )),
      ),
    );

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(
      MostUsedButton(
          buttonText: 'إضافة دور',
          buttonIcon: Icons.add_circle_outline,
          onTap: () {
            Get.to(() => const ModifyRoleScreen());
          }),
    );
    return const GlobalInterface();
  }

  TableRow _buildTableRow(
    PermessionModel role,
    Widget editButton,
    Widget deleteButton,
  ) {
    const textStyle = TextStyle(
      fontFamily: 'Arabic',
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );

    return TableRow(
      decoration: BoxDecoration(color: Colors.grey[200]),
      children: [
        /*    TableCell(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SwitchButton(
                    labelSize: 13,
                    height: 40,
                    width: 100,
                    toggleSize: 20,
                    initStatus: true,
                    onChange: (v) {},
                  )
                ],
              ),
            ),
          ),
        ),
       */
        TableCell(
          child: Center(
            child: Text(role.name ?? "", style: textStyle),
          ),
        ),
        TableCell(child: editButton),
        TableCell(child: deleteButton),
      ],
    );
  }
}
