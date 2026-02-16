// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/components/edit_button.dart';
import '../../../../core/components/retry_widget.dart';
import '../../../authentication/model/models/wholesale_user_model.dart';
import '../../controller/users_controller.dart';
import '../pages/modify_user_screen.dart';

class SalesmanUsersSection extends StatefulWidget {
  const SalesmanUsersSection({super.key});

  @override
  State<SalesmanUsersSection> createState() => _SalesmanUsersSectionState();
}

class _SalesmanUsersSectionState extends State<SalesmanUsersSection> {
  final UsersController? usersController = Get.put(UsersController());

  @override
  void initState() {
    usersController?.getWholesaleUsers(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: usersController!.obx(
              (state) => Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder.all(),
            columnWidths: const {
              0: FractionColumnWidth(0.3),
              1: FractionColumnWidth(0.3),
              2: FractionColumnWidth(0.2),
              3: FractionColumnWidth(0.2),
            },
            children: [
              const TableRow(
                children: [
                  TableCell(
                    child: Center(
                      child: Text('اسم المستخدم',
                          style: TextStyle(
                            fontFamily: 'Arabic',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(' رقم الجوال',
                          style: TextStyle(
                            fontFamily: 'Arabic',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text('تعديل الحساب',
                          style: TextStyle(
                            fontFamily: 'Arabic',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text('حذف الحساب',
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
                      Get.to(() => ModifyUserScreen(
                        user: item,
                      ));
                    },
                    icon: Icons.edit,
                    label: "تعديل",
                  ),
                  CellButton(
                    onTap: () async {
                      bool? isRefresh =
                      await usersController?.deleteUser(item.id ?? 0);
                      if (isRefresh ?? false) {
                        usersController?.getWholesaleUsers(false);
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
              func: () => print("لا يوجد نتائج"),
              //usersController?.getWholesaleUsers(true)),
            ),
          ),
          onError: (error) => Center(
            child: RetryWidget(
                error: error!,
                func: () => usersController?.getWholesaleUsers(true)),
          )),
    );
  }
  TableRow _buildTableRow(
      WholesaleUserModel user,
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
        TableCell(
          child: Center(
            child: Text(user.name ?? "", style: textStyle),
          ),
        ),
        TableCell(
          child: Center(
            child: Text(user.phoneNumber ?? "", style: textStyle),
          ),
        ),

        TableCell(child: editButton),
        TableCell(child: deleteButton),
      ],
    );
  }
}
