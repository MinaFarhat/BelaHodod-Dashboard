import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/style/constraint_style_features.dart';
import '../../../../../core/constants/style/text_style_features.dart';
import '../../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../../presentation/view/global_interface.dart';
import '../../../../core/components/retry_widget.dart';
import '../../../orders/view/widgets/label_widget.dart';
import '../../controller/coupon_details_controller.dart';
import '../../model/coupons_model.dart';

class CouponDetailsScreen extends StatefulWidget {
  final CouponsModel? coupon;

  const CouponDetailsScreen({super.key, this.coupon});

  @override
  State<CouponDetailsScreen> createState() => _CouponDetailsScreenState();
}

class _CouponDetailsScreenState extends State<CouponDetailsScreen> {
  final CouponDetailsController? couponController =
      Get.find<CouponDetailsController>();

  @override
  void initState() {
    couponController?.getCouponDetails(widget.coupon?.couponId, true);
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
          "تفاصيل القسيمة",
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );
    globalInterfaceController.addExtraWidget(
      couponController!.obx(
          (state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelWidget(
                    label: "المرسل:",
                    value: state?.senderName ?? "",
                  ),
                  LabelWidget(
                    label: "المستقبل:",
                    value: state?.receiverName ?? "",
                  ),
                  LabelWidget(
                    label: "القيمة الحالية:",
                    value: state?.valueLeft.toString() ?? "",
                  ),
                  LabelWidget(
                    label: "القيمة المتبقية:",
                    value: state?.valueLeft.toString() ?? "",
                  ),
                  LabelWidget(
                    label: "القيمة الكلية:",
                    value: state?.totalValue.toString() ?? "",
                  ),
                ],
              ),
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: Center(
            child: RetryWidget(
                error: "لا يوجد نتائج",
                func: () => couponController?.getCouponDetails(
                    widget.coupon?.couponId, true)),
          ),
          onError: (error) => Center(
                child: RetryWidget(
                    error: error!,
                    func: () => couponController?.getCouponDetails(
                        widget.coupon?.couponId, true)),
              )),
    );

    return const GlobalInterface();
  }
}
