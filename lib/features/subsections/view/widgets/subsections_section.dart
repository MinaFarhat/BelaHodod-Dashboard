import 'package:belahododdashboard/features/subsections/controller/subsection_controller.dart';
import 'package:belahododdashboard/features/subsections/view/widgets/subsection_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/components/retry_widget.dart';

class SubsectionsSection extends StatefulWidget {
  final int sectionId;

  const SubsectionsSection({super.key, required this.sectionId});

  @override
  State<SubsectionsSection> createState() => _SubsectionsSectionState();
}

class _SubsectionsSectionState extends State<SubsectionsSection> {
  final SubsectionsController? subsectionsController =
      Get.find<SubsectionsController>();

  @override
  void initState() {
    subsectionsController?.getSubsections(widget.sectionId, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20.px),
        child: subsectionsController!.obx(
          (state) => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                // Number of columns
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 300.px,
                childAspectRatio: 1),
            itemCount: state?.length ?? 0,
            itemBuilder: (context, index) {
              return SubSectionWidget(
                subsection: state![index],
                sectionId: widget.sectionId,
                onDelete: () {
                  subsectionsController?.getSubsections(
                      widget.sectionId, false);
                },
              );
            },
          ),
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: Center(
            child: RetryWidget(
                error: "لا يوجد نتائج",
                func: () => subsectionsController?.getSubsections(
                    widget.sectionId, true)),
          ),
          onError: (error) => Center(
              child: RetryWidget(
                  error: error!,
                  func: () => subsectionsController?.getSubsections(
                      widget.sectionId, true))),
        ));
  }
}
