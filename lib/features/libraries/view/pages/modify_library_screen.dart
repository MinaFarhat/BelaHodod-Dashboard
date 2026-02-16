import 'package:belahododdashboard/features/libraries/controller/libraries_controller.dart';
import 'package:belahododdashboard/features/libraries/model/models/library_model.dart';
import 'package:belahododdashboard/features/libraries/model/params/library_params.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/components/used_filled.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';
import '../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../core/components/most_used_button.dart';
import '../../../../presentation/view/global_interface.dart';

class ModifyLibraryScreen extends StatefulWidget {
  final LibraryModel? library;

  const ModifyLibraryScreen({super.key, this.library});

  @override
  State<ModifyLibraryScreen> createState() => _ModifyLibraryScreenState();
}

class _ModifyLibraryScreenState extends State<ModifyLibraryScreen> {
  final LibrariesController? librariesController =
      Get.find<LibrariesController>();
  final _libraryFormKey = GlobalKey<FormState>();
  LibraryParams params = LibraryParams();
  TextEditingController name = TextEditingController();

  @override
  void initState() {
    if (widget.library != null) {
      name.text = widget.library?.name ?? "";
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
          widget.library != null ? 'تعديل مكتبة' : 'إضافة مكتبة جديدة',
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );
    globalInterfaceController.addExtraWidget(Form(
      key: _libraryFormKey,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UsedFilled(
              label: 'اسم المكتبة',
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
          if (_libraryFormKey.currentState!.validate()) {
            _libraryFormKey.currentState?.save();

            if (widget.library != null) {
              librariesController?.updateLibrary(
                  widget.library?.id ?? 0, params);
            } else {
              librariesController?.addLibrary(params);
            }
          }
        },
      ),
    );
    return const GlobalInterface();
  }
}
