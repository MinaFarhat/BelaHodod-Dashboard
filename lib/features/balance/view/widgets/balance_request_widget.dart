import 'package:belahododdashboard/features/balance/model/balance_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/style/color_style_features.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';
import '../pages/balance_request_details_screen.dart';
class BalanceRequestWidget extends StatefulWidget {
  final BalanceRequestModel balanceRequest;

  const BalanceRequestWidget({
    super.key,
    required this.balanceRequest,
  });

  @override
  State<BalanceRequestWidget> createState() => _BalanceRequestWidgetState();
}

class _BalanceRequestWidgetState extends State<BalanceRequestWidget> {
  TextStyleFeatures textStyleFeatures = TextStyleFeatures();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => BalanceRequestDetailsScreen(
              balanceRequest: widget.balanceRequest,
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
            final double cardPadding = availableWidth *
                ConstraintStyleFeatures
                    .cardPaddingRatio; // Use the extracted constraint constant

            return Center(
              child: Container(
                padding: EdgeInsets.all(cardPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.balanceRequest.userName ?? "",
                      style: textStyleFeatures.cardTitleTextStyle(
                          availableWidth, true),
                      textAlign: TextAlign.center,
                    ),
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
