import 'package:belahododdashboard/features/reports/controller/reports_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/constants/style/constraint_style_features.dart';
import '../../../../../core/constants/style/text_style_features.dart';
import '../../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../../core/components/most_used_button.dart';
import '../../../../../presentation/view/global_interface.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final ReportsController? reportsController = Get.find<ReportsController>();

  @override
  void initState() {
    // reportsController?.getReport();
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
          "عرض التقارير",
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );
    globalInterfaceController.addExtraWidget(Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 2.h,
          ),

          // reportsController!.obx(
          //         (state) =>  SfPdfViewer.memory(state!,
          // ),
          //     onLoading: const Center(child: CircularProgressIndicator()),
          //     onEmpty: Center(
          //       child: RetryWidget(
          //           error: "لا يوجد نتائج",
          //           func: () => reportsController?.getReport()),
          //     ),
          //     onError: (error) => Center(
          //       child: RetryWidget(
          //           error: error!,
          //           func: () => reportsController?.getReport()),
          //     )),
        ],
      ),
    ));

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(
      MostUsedButton(
        buttonText: 'استيراد',
        buttonIcon: Icons.arrow_circle_down,
        onTap: () async {
          reportsController!.downloadFile(
            "http://127.0.0.1:8000/api/report",
            "report.pdf",
          );
        },
      ),
    );

    return const GlobalInterface();
  }
}
