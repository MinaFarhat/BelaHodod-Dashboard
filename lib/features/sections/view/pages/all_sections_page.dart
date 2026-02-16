import 'package:belahododdashboard/features/sections/view/pages/modify_section_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/components/most_used_button.dart';
import '../../../../core/components/retry_widget.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';
import '../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../presentation/view/global_interface.dart';
import '../../../products/controller/file_upload_controller.dart';
import '../widgets/section_widget.dart';

import '../../controller/all_sections_controller.dart';

class AllSectionsScreen extends StatefulWidget {
  const AllSectionsScreen({super.key});

  @override
  State<AllSectionsScreen> createState() => _AllSectionsScreenState();
}

class _AllSectionsScreenState extends State<AllSectionsScreen> {
  final AllSectionsController? getAllSectionsController =
      Get.find<AllSectionsController>();
  final FileUploadController fileUploadController =
      Get.put(FileUploadController());
  @override
  void initState() {
    getAllSectionsController?.getAllSections();
    super.initState();
  }

  void _selectFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xls', 'xlsx'], // Allow Excel file types only
    );

    if (result != null) {
      fileUploadController.addExcelFile(
          result.files.first.bytes!, result.files.first.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalInterfaceController globalInterfaceController =
        Get.put(GlobalInterfaceController());
    globalInterfaceController.removeExtraWidgets();
    globalInterfaceController.addExtraWidget(
      Center(
        child: Text(
          'الأقسام الموجودة حالياً',
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(
      Expanded(
        child: getAllSectionsController!.obx(
            (state) => GridView.builder(
                  padding:
                      EdgeInsets.all(ConstraintStyleFeatures.gridsPadding()),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: state?.length ?? 0,
                  itemBuilder: (context, index) {
                    return SectionWidget(
                      section: state![index],
                      sectionsNumber: state.length,
                    );
                  },
                ),
            onLoading: const Center(child: CircularProgressIndicator()),
            onEmpty: Center(
              child: RetryWidget(
                  error: "لا يوجد نتائج",
                  func: () => getAllSectionsController?.getAllSections()),
            ),
            onError: (error) => Center(
                  child: RetryWidget(
                      error: error!,
                      func: () => getAllSectionsController?.getAllSections()),
                )),
      ),
    );

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getAllSectionsController!.obx(
            (state) => MostUsedButton(
                buttonText: 'أضف قسما جديدا',
                buttonIcon: Icons.add_circle_outline,
                onTap: () {
                  Get.to(() => ModifySectionScreen(
                        sectionsNumber: state?.length,
                      ));
                }),
            onLoading: const SizedBox(),
            onEmpty: MostUsedButton(
              buttonText: 'أضف قسما جديدا',
              buttonIcon: Icons.add_circle_outline,
              onTap: () {
                Get.to(() => const ModifySectionScreen(sectionsNumber: 5));
              },
            ),
            onError: (error) => MostUsedButton(
                buttonText: 'أضف قسما جديدا',
                buttonIcon: Icons.add_circle_outline,
                onTap: () {
                  Get.to(() => const ModifySectionScreen(sectionsNumber: 5));
                })),
        getAllSectionsController!.obx(
            (state) => MostUsedButton(
                buttonText: 'أضف منتجات',
                buttonIcon: Icons.add_circle_outline,
                onTap: () {
                  _selectFile();
                }),
            onLoading: const SizedBox(),
            onEmpty: MostUsedButton(
              buttonText: 'أضف منتجات',
              buttonIcon: Icons.add_circle_outline,
              onTap: () {
                _selectFile();
              },
            ),
            onError: (error) => MostUsedButton(
                buttonText: 'أضف منتجات',
                buttonIcon: Icons.add_circle_outline,
                onTap: () {
                  _selectFile();
                })),
      ],
    ));

    return const GlobalInterface();
  }
}
