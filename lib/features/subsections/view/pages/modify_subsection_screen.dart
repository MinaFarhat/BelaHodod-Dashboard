import 'package:belahododdashboard/features/subsections/controller/subsection_controller.dart';
import 'package:belahododdashboard/features/subsections/model/models/subsection_model.dart';
import 'package:belahododdashboard/features/subsections/model/params/subsection_params.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/components/used_filled.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';
import '../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../core/components/most_used_button.dart';
import '../../../../presentation/view/global_interface.dart';

class ModifySubsectionScreen extends StatefulWidget {
  final int? sectionId;
  final SubsectionModel? subsection;

  const ModifySubsectionScreen({super.key, this.subsection, this.sectionId});

  @override
  State<ModifySubsectionScreen> createState() => _ModifySubsectionScreenState();
}

class _ModifySubsectionScreenState extends State<ModifySubsectionScreen> {
  final SubsectionsController? subsectionsController =
      Get.find<SubsectionsController>();
  final _subsectionsFormKey = GlobalKey<FormState>();
  SubsectionParams params = SubsectionParams();
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    if (widget.subsection != null) {
      name.text = widget.subsection?.name ?? "";
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
          widget.subsection != null ? 'تعديل قسم فرعي' : 'إضافة قسم فرعي',
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );
    globalInterfaceController.addExtraWidget(Form(
      key: _subsectionsFormKey,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UsedFilled(
              label: 'اسم القسم الفرعي',
              controller: name,
              isMandatory: true,
              onSaved: (value) {
                params.name = value;
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
          if (_subsectionsFormKey.currentState!.validate()) {
            _subsectionsFormKey.currentState?.save();

            if (widget.subsection != null) {
              subsectionsController?.updateSubsection(
                  widget.sectionId ?? 0, widget.subsection?.id ?? 0, params);
            } else {
              subsectionsController?.addSubsection(
                  widget.sectionId ?? 0, params);
            }
          }
        },
      ),
    );
    return const GlobalInterface();
  }
}
