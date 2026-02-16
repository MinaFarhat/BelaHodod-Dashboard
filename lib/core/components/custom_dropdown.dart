import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../presentation/controllers/dropdown_list_controller.dart';
import '../constants/style/color_style_features.dart';
import '../constants/style/text_style_features.dart';

class CustomDropdownWidget extends StatefulWidget {
  final DropdownListController dropdownController;

  const CustomDropdownWidget({super.key, required this.dropdownController});

  @override
  State<CustomDropdownWidget> createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              widget.dropdownController.isExpanded.value =
                  !widget.dropdownController.isExpanded.value;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.dropdownController.name,
                    style: widget.dropdownController.textStyleFeatures
                        .dropdownNameTextStyle(
                            widget.dropdownController.isExpanded.value),
                  ),
                ),
                Icon(
                  widget.dropdownController.isExpanded.value
                      ? Icons.expand_less
                      : Icons.expand_more,
                  color: widget.dropdownController.isExpanded.value
                      ? ColorStyleFeatures.onHoverColor
                      : ColorStyleFeatures.dropdownChoiceTextColor,
                ),
              ],
            ),
          ),
        ),
        if (widget.dropdownController.isExpanded.value)
          Container(
            decoration: BoxDecoration(
              color: ColorStyleFeatures.dropdownChoicesBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: const BoxConstraints(maxHeight: 300),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.dropdownController.choices.length,
              itemBuilder: (context, index) {
                final choice = widget.dropdownController.choices[index];
                final isHovered =
                    index == widget.dropdownController.hoveredIndex.value;

                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) {
                    setState(() {
                      widget.dropdownController.hoveredIndex.value = index;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      widget.dropdownController.hoveredIndex.value = -1;
                    });
                  },
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.dropdownController.isExpanded.value = false;
                        widget.dropdownController.selectedChoice.value = choice;
                        widget.dropdownController.hoveredIndex.value = -1;
                      });
                      widget.dropdownController.printSelectedChoice();
                      Get.offNamed(widget.dropdownController
                          .searchInsideBarRoutes(choice));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isHovered
                            ? ColorStyleFeatures.dropdownChoiceHoverColor
                            : ColorStyleFeatures.dropdownChoiceNonHoverColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        choice,
                        style: TextStyleFeatures.sideBarTextStyle,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
