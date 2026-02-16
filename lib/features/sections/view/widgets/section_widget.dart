// ignore_for_file: must_be_immutable

import 'package:belahododdashboard/features/sections/model/params/section_params.dart';
import 'package:belahododdashboard/features/sections/view/pages/modify_section_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/components/switch_button.dart';
import '../../../../core/constants/style/color_style_features.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';
import '../../controller/all_sections_controller.dart';
import '../../model/models/section_model.dart';

import '../../../../core/components/custom_button.dart';
import '../pages/section_details_screen.dart';

class SectionWidget extends StatefulWidget {
  SectionModel section;
  int sectionsNumber;

  SectionWidget(
      {super.key, required this.section, required this.sectionsNumber});

  @override
  State<SectionWidget> createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  TextStyleFeatures textStyleFeatures = TextStyleFeatures();
  final AllSectionsController? getAllSectionsController =
      Get.find<AllSectionsController>();

  bool status = false;

  @override
  void initState() {
    status = widget.section.isVisible == 1 ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SectionDetailsScreen(
              sectionId: widget.section.id,
            ));
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
            final double availableHeight = constraints.maxHeight;
            final double cardPadding = availableWidth *
                ConstraintStyleFeatures
                    .cardPaddingRatio; // Use the extracted constraint constant

            return Stack(
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(cardPadding,
                        constraints.maxHeight * 0.3, cardPadding, cardPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.section.name ?? "",
                          style: textStyleFeatures.cardTitleTextStyle(
                              availableWidth, true),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                            height: availableHeight *
                                ConstraintStyleFeatures
                                    .cardVerticalSpacingRatio),
                        // Use the extracted constraint constant
                        Text(
                          widget.section.description ?? "",
                          style: textStyleFeatures.cardTitleTextStyle(
                              availableWidth, false),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomButton(
                        constraints: constraints,
                        icon: Icons.edit,
                        backgroundColor: ColorStyleFeatures.headLinesTextColor,
                        onTap: () {
                          Get.to(() => ModifySectionScreen(
                                section: widget.section,
                                sectionsNumber: widget.sectionsNumber,
                              ));
                        },
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      SwitchButton(
                        initStatus: status,
                        onChange: (value) async {
                          SectionParams params = SectionParams(
                              name: widget.section.name,
                              description: widget.section.description,
                              isVisible: value,
                              priority: widget.section.priority);
                          bool? isSuccess = await getAllSectionsController
                              ?.updateSectionStatus(
                                  widget.section.id ?? 0, params);
                          if (isSuccess ?? false) {
                            setState(() {
                              status = value;
                            });
                          }
                        },
                      )
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
