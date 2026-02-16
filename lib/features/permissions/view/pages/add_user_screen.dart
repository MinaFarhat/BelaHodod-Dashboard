import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';
import '../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../core/components/most_used_button.dart';
import '../../../../presentation/view/global_interface.dart';
import 'package:belahododdashboard/features/permissions/controller/users_controller.dart';
import 'package:belahododdashboard/features/authentication/model/params/new_user_params.dart';

class AddUserScreen extends StatefulWidget {
  final int sectionId;
  const AddUserScreen({super.key, required this.sectionId});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final UsersController? usersController = Get.put(UsersController());
  final _userFormKey = GlobalKey<FormState>();

  NewUserParams params = NewUserParams();

  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  void initState() {
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
          'إضافة حساب',
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
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                labelText: 'اسم المستخدم',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'اسم المستخدم مطلوب';
                }
                return null;
              },
              onSaved: (value) {
                params.name = value;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: password,
              decoration: const InputDecoration(
                labelText: 'كلمة السر',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'كلمة السر مطلوبة';
                }
                return null;
              },
              onSaved: (value) {
                params.password = value;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordConfirmation,
              decoration: const InputDecoration(
                labelText: 'تأكيد كلمة السر',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'تأكيد كلمة السر مطلوب';
                }
                if (value != password.text) {
                  return 'كلمتا السر غير متطابقتين';
                }
                return null;
              },
              onSaved: (value) {
                params.passwordConfirmation = value;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: phoneNumber,
              decoration: const InputDecoration(
                labelText: 'رقم الهاتف',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'رقم الهاتف مطلوب';
                }
                return null;
              },
              onSaved: (value) {
                params.phoneNumber = value;
              },
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
            _userFormKey.currentState?.save();

            if (widget.sectionId == 0) {
              usersController?.addUser(params, "S");
            } else if (widget.sectionId == 1) {
              usersController?.addUser(params, "W");
            }
          }
        },
      ),
    );
    return const GlobalInterface();
  }
}
