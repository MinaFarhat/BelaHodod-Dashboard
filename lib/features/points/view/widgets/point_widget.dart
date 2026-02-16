import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/constants/style/color_style_features.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../model/point_model.dart';

class PointWidget extends StatefulWidget {
  final PointModel point;

  const PointWidget({
    super.key,
    required this.point,
  });

  @override
  State<PointWidget> createState() => _PointWidgetState();
}

class _PointWidgetState extends State<PointWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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

            return Center(
              child: Container(
                padding: EdgeInsets.all(cardPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.point.name ?? ""}:",
                      style: const TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(widget.point.points.toString(),
                        style: const TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
