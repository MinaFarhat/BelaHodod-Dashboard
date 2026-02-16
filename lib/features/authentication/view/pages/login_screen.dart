import 'package:belahododdashboard/features/authentication/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/constants/style/color_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';
import '../../model/params/login_params.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final AuthenticationController? loginController =
      Get.find<AuthenticationController>();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  LoginParams loginParams = LoginParams();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AspectRatio(
                aspectRatio: constraints.maxWidth * 0.00047,
                //0.74,
                child: Image.asset(
                  'web/icons/loginImage.jfif',
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.px),
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        Center(
                          child: Text(
                            "لوحة تحكم المنصة",
                            style: TextStyleFeatures.headLinesTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 18.h,
                        ),
                        Center(
                          child: Text(
                            "تسجيل الدخول",
                            style: TextStyleFeatures.generalTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "أدخل المعلومات الشخصية لحساب المسؤول خاصتك",
                            style: TextStyleFeatures.generalTextStyle,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.8,
                          height: constraints.maxHeight * 0.08,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.grey[300],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth * 0.067),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "اسم المستخدم",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: constraints.maxHeight * 0.022,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.013,
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.1,
                                  height: constraints.maxHeight * 0.08,
                                  child: Center(
                                    child: TextFormField(
                                      controller: userName,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {},
                                      onSaved: (value) {
                                        loginParams.name = userName.text;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'ادخل قيمة';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.03 * MediaQuery.of(context).size.height,
                        ),
                        Container(
                          width: constraints.maxWidth * 0.4,
                          height: constraints.maxHeight * 0.08,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.grey[300],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: constraints.maxWidth * 0.067),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "كلمة المرور",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: constraints.maxHeight * 0.022,
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.03,
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.1,
                                  height: constraints.maxHeight * 0.08,
                                  child: Center(
                                    child: TextFormField(
                                      controller: password,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {},
                                      obscureText: true,
                                      onSaved: (value) {
                                        loginParams.password = password.text;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'ادخل قيمة';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          "نسيت كلمة المرور",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: constraints.maxWidth * 0.015,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.05,
                          width: constraints.maxWidth * 0.18,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_loginFormKey.currentState!.validate()) {
                                _loginFormKey.currentState?.save();

                                loginController?.loginApi(loginParams);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  ColorStyleFeatures.mostUsedButtonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // Align children in the center vertically
                              children: [
                                Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.px,
                                  ),
                                  textDirection: TextDirection
                                      .rtl, // Set text direction to right-to-left for Arabic
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
      );
    });
  }
}
