import 'package:belahododdashboard/features/authentication/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/components/used_filled.dart';
import '../../../../../core/constants/style/constraint_style_features.dart';
import '../../../../../core/constants/style/text_style_features.dart';
import '../../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../../core/components/most_used_button.dart';
import '../../../../../presentation/view/global_interface.dart';
import '../../model/params/user_info_params.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final _accountSettingsFormKey = GlobalKey<FormState>();
  UserInfoParams params = UserInfoParams();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  final AuthenticationController? authenticationController =
      Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    final GlobalInterfaceController globalInterfaceController =
        Get.put(GlobalInterfaceController());
    globalInterfaceController.removeExtraWidgets();
    globalInterfaceController.addExtraWidget(
      Center(
        child: Text(
          "إعدادات الحساب",
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );
    globalInterfaceController.addExtraWidget(Expanded(
      child: Form(
          key: _accountSettingsFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 2.h,
              ),
              UsedFilled(
                label: 'اسم المستخدم',
                controller: name,
                isMandatory: true,
                onSaved: (value) {
                  params.name = value;
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              UsedFilled(
                label: 'كلمة المرور',
                controller: password,
                isMandatory: true,
                obscureText: true,
                onSaved: (value) {
                  params.password = value;
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              UsedFilled(
                label: 'رقم الجوال',
                controller: phoneNumber,
                isMandatory: true,
                onSaved: (value) {
                  params.phoneNumber = value;
                },
              ),
            ],
          )),
    ));

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(
      MostUsedButton(
        buttonText: 'حفظ',
        buttonIcon: Icons.save,
        onTap: () async {
          if (_accountSettingsFormKey.currentState!.validate()) {
            _accountSettingsFormKey.currentState?.save();
            authenticationController?.changeUserInfo(params);
          }
        },
      ),
    );

    return const GlobalInterface();
  }
}
