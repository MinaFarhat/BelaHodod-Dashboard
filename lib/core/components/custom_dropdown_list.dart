import 'package:belahododdashboard/features/products/controller/selected_item_dropdown_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../constants/style/color_style_features.dart';
import '../constants/style/text_style_features.dart';

class CustomDropdownList extends StatefulWidget {
  final String label;
  final String hint;

  final List<DropdownMenuItem<int>>? items;
  final List<DropdownMenuItem<String>>? sItems;
  final List<DropdownMenuItem<dynamic>>? dItems;
  final dynamic selectedItem;
  final Function(dynamic value) onChanged;

  const CustomDropdownList({
    super.key,
    required this.label,
    required this.hint,
    this.items,
    this.selectedItem,
    required this.onChanged,
    this.sItems,
    this.dItems,
  });

  @override
  State<CustomDropdownList> createState() => _CustomDropdownListState();
}

class _CustomDropdownListState extends State<CustomDropdownList> {
  final SelectedItemDropdownController? selectedItemDropdownController =
      Get.find<SelectedItemDropdownController>();

  @override
  void initState() {
    super.initState();

    // Check if the widget.sItems list is not null and not empty
    if (widget.sItems != null && widget.sItems!.isNotEmpty) {
      // Check if the selectedItem is provided and exists in the list
      final selectedItemExists =
          widget.sItems!.any((item) => item.value == widget.selectedItem);

      if (selectedItemExists) {
        // If the selectedItem exists in the list, use it
        selectedItemDropdownController?.change(widget.selectedItem);
      } else {
        // If not, use the first item in the list as the default value
        selectedItemDropdownController
            ?.change(widget.sItems!.first.value ?? "");
      }
    } else {
      // If the list is null or empty, set a fallback value
      selectedItemDropdownController?.change("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.label,
          style: TextStyleFeatures.generalTextStyle,
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(width: 25),
        Container(
          height: 8.h,
          width: 100.w * 100.h * 0.0004,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorStyleFeatures.headLinesTextColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: widget.items != null
              ? DropdownButton<int>(
                  hint: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      widget.hint,
                      style: TextStyle(fontSize: 14.px),
                    ),
                  ),
                  underline: Container(),
                  value: widget.selectedItem as int?,
                  onChanged: (int? selectedItem) {
                    widget.onChanged(selectedItem);
                  },
                  items: widget.items?.toList(),
                )
              : widget.dItems != null
                  ? DropdownButton<dynamic>(
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          widget.hint,
                          style: TextStyle(fontSize: 14.px),
                        ),
                      ),
                      underline: Container(),
                      value: widget.selectedItem,
                      onChanged: (dynamic selectedItem) {
                        widget.onChanged(selectedItem);
                      },
                      items: widget.dItems?.toList(),
                    )
                  : Obx(
                      () => DropdownButton<String>(
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            widget.hint,
                            style: TextStyle(fontSize: 14.px),
                          ),
                        ),
                        underline: Container(),
                        value:
                            selectedItemDropdownController?.selectedItem.value,
                        onChanged: (String? selectedItem) {
                          selectedItemDropdownController
                              ?.change(selectedItem ?? "");
                          widget.onChanged(selectedItem);
                        },
                        items: widget.sItems?.toList(),
                      ),
                    ),
        ),
      ],
    );
  }
}
