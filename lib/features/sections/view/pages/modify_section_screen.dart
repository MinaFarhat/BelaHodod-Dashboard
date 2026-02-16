import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/components/custom_dropdown_list.dart';
import '../../../../core/components/used_filled.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';
import '../../../subsections/controller/dropdown_controller.dart';
import '../../controller/all_sections_controller.dart';
import '../../model/models/section_model.dart';
import '../../model/params/section_params.dart';
import '../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../core/components/most_used_button.dart';
import '../../../../presentation/view/global_interface.dart';

class ModifySectionScreen extends StatefulWidget {
  final SectionModel? section;
  final int? sectionsNumber;

  const ModifySectionScreen({super.key, this.section, this.sectionsNumber});

  @override
  State<ModifySectionScreen> createState() => _ModifySectionScreenState();
}

class _ModifySectionScreenState extends State<ModifySectionScreen> {
  final AllSectionsController? getAllSectionsController =
      Get.find<AllSectionsController>();
  final DropdownController? dropdownController = Get.find<DropdownController>();


  final _sectionFormKey = GlobalKey<FormState>();
  SectionParams params = SectionParams();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    if (widget.section != null) {
      name.text = widget.section?.name ?? "";
      description.text = widget.section?.description ?? "";
      dropdownController?.change(widget.section?.priority ?? 1);
    }

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
          widget.section != null ? 'تعديل قسم' : 'إضافة قسم جديد',
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );
    globalInterfaceController.addExtraWidget(Form(
      key: _sectionFormKey,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UsedFilled(
              label: 'اسم القسم',
              controller: name,
              isMandatory: true,
              onSaved: (value) {
                params.name = value;
              },
            ),
            UsedFilled(
              label: 'الوصف',
              controller: description,
              isMandatory: true,
              onSaved: (value) {
                params.description = value;
              },
            ),
            SizedBox(
              height: 2.h,
            ),

            Obx(() => CustomDropdownList(
                  hint: "ترتيب القسم",
                  label: "ترتيب القسم",
                  onChanged: (value) {
                    dropdownController?.change(value);
                  },
                  items: List<DropdownMenuItem<int>>.generate(
                      widget.sectionsNumber ?? 0, (index) {
                    return DropdownMenuItem<int>(
                      value: index + 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(fontSize: 18.px),
                        ),
                      ),
                    );
                  }),
                  selectedItem: dropdownController?.selectedItem.value,
                )),

            // Row(
            //   children: [
            //     Text(
            //       "ترتيب القسم",
            //       style: TextStyleFeatures.generalTextStyle,
            //       textDirection: TextDirection.rtl,
            //     ),
            //     const SizedBox(width: 25),
            //     Container(
            //       height: 8.h,
            //       width: 100.w * 100.h * 0.0004,
            //       decoration: BoxDecoration(
            //         border: Border.all(
            //           color: ColorStyleFeatures.headLinesTextColor,
            //           width: 2.0,
            //         ),
            //         borderRadius: BorderRadius.circular(8.0),
            //       ),
            //       child: DropdownButton<int>(
            //         hint: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //           child: Text(
            //             "ترتيب القسم",
            //             style: TextStyle(fontSize: 14.px),
            //           ),
            //         ),
            //         underline: Container(),
            //         value: _selectedItem,
            //         onChanged: (int? selectedItem) {
            //           setState(() {
            //             _selectedItem = selectedItem;
            //           });
            //         },
            //         items: List<DropdownMenuItem<int>>.generate(
            //             widget.sectionsNumber ?? 0, (index) {
            //           return DropdownMenuItem<int>(
            //             value: index + 1,
            //             child: Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //               child: Text(
            //                 '${index + 1}',
            //                 style: TextStyle(fontSize: 18.px),
            //               ),
            //             ),
            //           );
            //         }).toList(),
            //       ),
            //     ),
            //   ],
            // ),
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
          if (_sectionFormKey.currentState!.validate()) {
            _sectionFormKey.currentState?.save();
            params.priority = dropdownController?.selectedItem.value;
            if (widget.section != null) {
              getAllSectionsController?.updateSection(
                  widget.section?.id ?? 0, params);
            } else {
              getAllSectionsController?.addSection(params);
            }
          }
        },
      ),
    );
    return const GlobalInterface();
  }
}
