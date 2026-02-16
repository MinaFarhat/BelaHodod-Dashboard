import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/constants/style/color_style_features.dart';
import '../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../presentation/view/global_interface.dart';

class PendingOrderDetailsScreen extends StatefulWidget {
  const PendingOrderDetailsScreen({super.key});

  @override
  State<PendingOrderDetailsScreen> createState() =>
      _PendingOrderDetailsScreenState();
}

class _PendingOrderDetailsScreenState extends State<PendingOrderDetailsScreen> {
  String? _selectedItem;
  final List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalInterfaceController globalInterfaceController =
        Get.put(GlobalInterfaceController());
    globalInterfaceController.removeExtraWidgets();

    globalInterfaceController.addExtraWidget(Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 7.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.px),
                color: ColorStyleFeatures.headLinesTextColor,
              ),
              child: Center(
                child: Text(
                  "تفاصييل الطلب رقم 123456",
                  style: TextStyle(color: Colors.white, fontSize: 18.px),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "اسم صاحب\n الطلب:",
                            style: TextStyle(
                                fontSize: 15.px, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Container(
                            height: 6.h,
                            width: 15.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.px),
                                color: Colors.grey),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'ادخل قيمة';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "رقم الهاتف:",
                            style: TextStyle(
                                fontSize: 15.px, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Container(
                            height: 6.h,
                            width: 15.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.px),
                                color: Colors.grey),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'ادخل قيمة';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        height: 6.h,
                        width: 20.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorStyleFeatures.headLinesTextColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: DropdownButton<String>(
                          hint: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "حالة الطلب",
                              style: TextStyle(fontSize: 12.px),
                            ),
                          ),
                          underline: Container(),
                          value: _selectedItem,
                          items: _items.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 13.px),
                              ),
                            );
                          }).toList(),
                          // hint: Text('Select an item'),

                          onChanged: (String? selectedItem) {
                            setState(() {
                              _selectedItem = selectedItem;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        width: 12.w,
                        height: 7.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.px),
                          color: ColorStyleFeatures.headLinesTextColor,
                        ),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "العنوان",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.px),
                          ),
                        )),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        width: 12.w,
                        height: 7.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.px),
                          color: ColorStyleFeatures.headLinesTextColor,
                        ),
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "ملاحظات من الزبون",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.px),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const Text("تفاصيل الطلب"),
                      Container(
                        height: 50.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.px),
                            border: Border.all(
                              color: ColorStyleFeatures.headLinesTextColor,
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
    return const GlobalInterface();
  }
}
