import 'package:belahododdashboard/features/subsections/controller/subsection_controller.dart';
import 'package:belahododdashboard/features/subsections/model/models/subsection_model.dart';
import 'package:belahododdashboard/features/subsections/view/pages/modify_subsection_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/constants/style/color_style_features.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';
import '../pages/subsection_details.dart';

class SubSectionWidget extends StatefulWidget {
  final SubsectionModel subsection;
  final int sectionId;
  final Function onDelete;

  const SubSectionWidget(
      {super.key,
      required this.subsection,
      required this.onDelete,
      required this.sectionId});

  @override
  State<SubSectionWidget> createState() => _SubSectionWidgetState();
}

class _SubSectionWidgetState extends State<SubSectionWidget> {
  final SubsectionsController? subsectionsController =
      Get.find<SubsectionsController>();
  TextStyleFeatures textStyleFeatures = TextStyleFeatures();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SubsectionDetailsScreen(
            subsectionId: widget.subsection.id, sectionId: widget.sectionId));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: ColorStyleFeatures.cardColor,
        // Use the extracted color constant
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double availableWidth = constraints.maxWidth;
            final double cardPadding = availableWidth *
                ConstraintStyleFeatures
                    .cardPaddingRatio; // Use the extracted constraint constant

            return Stack(
              children: [
                Center(
                    child: Container(
                  padding: EdgeInsets.all(cardPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.subsection.name ?? "",
                        style: textStyleFeatures.cardTitleTextStyle(
                            availableWidth, true),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomButton(
                        constraints: constraints,
                        icon: Icons.edit,
                        backgroundColor: ColorStyleFeatures.headLinesTextColor,
                        onTap: () {
                          Get.to(() => ModifySubsectionScreen(
                                subsection: widget.subsection,
                                sectionId: widget.sectionId,
                              ));
                        },
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      CustomButton(
                        constraints: constraints,
                        icon: Icons.delete,
                        backgroundColor: Colors.red[600]!,
                        onTap: () async {
                          bool? isSuccess = await subsectionsController
                              ?.deleteSubsection(widget.subsection.id ?? 0);
                          if (isSuccess ?? false) {
                            widget.onDelete();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
