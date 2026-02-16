import 'package:flutter/material.dart';

import '../../core/components/custom_dropdown.dart';
import '../../presentation/controllers/dropdown_list_controller.dart';
import '../constants/style/constraint_style_features.dart';
import '../constants/style/text_style_features.dart';

class CustomSidebar extends StatelessWidget {
  final String loggedInUser;
  final List<DropdownListController> dropdowns;

  const CustomSidebar({
    super.key,
    required this.dropdowns,
    required this.loggedInUser,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set the text direction to RTL
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 250),
        color: const Color.fromRGBO(48, 55, 123, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
                height: ConstraintStyleFeatures.spaceBetweenElements),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    0, 0, 0, ConstraintStyleFeatures.spaceBetweenElements),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(48, 55, 123, 1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                    ),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical:
                              ConstraintStyleFeatures.spaceBetweenElements),
                      child: Text(
                        'بلا حدود',
                        style: TextStyleFeatures.sideBarTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
                height: ConstraintStyleFeatures.spaceBetweenElements),
            Expanded(
              child: ListView.builder(
                itemCount: dropdowns.length,
                itemBuilder: (context, index) {
                  if (index < dropdowns.length - 1) {
                    return Column(
                      children: [
                        CustomDropdownWidget(
                            dropdownController: dropdowns[index]),
                        const SizedBox(
                            height:
                                ConstraintStyleFeatures.spaceBetweenElements),
                      ],
                    );
                  } else {
                    return CustomDropdownWidget(
                        dropdownController: dropdowns[index]);
                  }
                },
              ),
            ),
            const SizedBox(
                height: ConstraintStyleFeatures.spaceBetweenElements),
            Padding(
              padding: const EdgeInsets.all(
                  ConstraintStyleFeatures.spaceBetweenElements),
              child: Text(
                loggedInUser,
                style: TextStyleFeatures.sideBarTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
