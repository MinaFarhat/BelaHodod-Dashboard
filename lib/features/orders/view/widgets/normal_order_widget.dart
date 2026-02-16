import 'package:belahododdashboard/features/orders/model/models/normal_order_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/constants/style/color_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';

class NormalOrderWidget extends StatelessWidget {
  final NormalOrderModel order;
  final Function? onTap;
  final BoxConstraints? constraints;

  NormalOrderWidget(
      {super.key, required this.order, this.onTap, required this.constraints})
      : textStyleFeatures =
            TextStyleFeatures.textStyleFeaturesWithConstraints(constraints);

  final TextStyleFeatures textStyleFeatures;
  @override
  Widget build(BuildContext context) {
    double maxSize = constraints!.maxHeight * constraints!.maxWidth;
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.px),
            color: ColorStyleFeatures.headLinesTextColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(maxSize * 0.00001),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: constraints!.maxHeight * 0.09,
                      width: constraints!.maxWidth * 0.10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.px),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          order.id.toString(),
                          textAlign: TextAlign.center,
                          style: textStyleFeatures
                              .generalTextStyleWithConstraints(),
                        ),
                      ),
                    ),
                    Container(
                      height: constraints!.maxHeight * 0.09,
                      width: constraints!.maxWidth * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.px),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Text(
                            order.paymentMethod.toString(),
                            textAlign: TextAlign.center,
                            style: textStyleFeatures
                                .generalTextStyleWithConstraints(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: constraints!.maxHeight * 0.09,
                      width: constraints!.maxWidth * 0.14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.px),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Text(
                            order.address.toString(),
                            textAlign: TextAlign.center,
                            style: textStyleFeatures
                                .generalTextStyleWithConstraints(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //550.6399780273438
                Container(
                  height: constraints!.maxHeight * 0.40,
                  width: constraints!.maxWidth * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.px),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      order.notes.toString(),
                      textAlign: TextAlign.center,
                      style:
                          textStyleFeatures.generalTextStyleWithConstraints(),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
