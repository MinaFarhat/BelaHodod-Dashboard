import 'package:belahododdashboard/features/balance/controller/balance_request_details_controller.dart';
import 'package:belahododdashboard/features/balance/model/balance_request_model.dart';
import 'package:belahododdashboard/features/balance/model/balance_request_params.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/components/used_filled.dart';
import '../../../../../core/constants/style/constraint_style_features.dart';
import '../../../../../core/constants/style/text_style_features.dart';
import '../../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../../core/components/most_used_button.dart';
import '../../../../../presentation/view/global_interface.dart';
import '../../../../core/components/retry_widget.dart';
import '../../../../core/constants/urls.dart';
import '../../../orders/view/widgets/label_widget.dart';

class BalanceRequestDetailsScreen extends StatefulWidget {
  final BalanceRequestModel? balanceRequest;

  const BalanceRequestDetailsScreen({super.key, this.balanceRequest});

  @override
  State<BalanceRequestDetailsScreen> createState() =>
      _BalanceRequestDetailsScreenState();
}

class _BalanceRequestDetailsScreenState
    extends State<BalanceRequestDetailsScreen> {
  final BalanceRequestsDetailsController? balanceRequestsDetailsController =
      Get.find<BalanceRequestsDetailsController>();

  final _balanceRequestDetailsFormKey = GlobalKey<FormState>();
  BalanceRequestParams params = BalanceRequestParams();
  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    balanceRequestsDetailsController
        ?.getBalanceRequestDetails(widget.balanceRequest?.id ?? -1);

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
          "تفاصيل طلب تعبئة المحفظة",
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );
    globalInterfaceController.addExtraWidget(
      balanceRequestsDetailsController!.obx(
          (state) => Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _balanceRequestDetailsFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelWidget(
                          label: "اسم المرسل:",
                          value: state?.userName ?? "",
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(15.sp)),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.sp),
                              child: Image.network(
                                height: 300,
                                width: 300,
                                Urls.imageUrl +
                                    state!.image![0]
                                        .replaceAll('[', "")
                                        .replaceAll(']', '')
                                        .replaceAll('"', "")
                                        .replaceAll("\\", ""),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        UsedFilled(
                          label: 'الكمية',
                          controller: amount,
                          isMandatory: true,
                          onSaved: (value) {
                            params.amount = int.parse(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: Center(
            child: RetryWidget(
                error: "لا يوجد نتائج",
                func: () =>
                    balanceRequestsDetailsController?.getBalanceRequestDetails(
                        widget.balanceRequest?.id ?? -1)),
          ),
          onError: (error) => Center(
                child: RetryWidget(
                    error: error!,
                    func: () => balanceRequestsDetailsController
                        ?.getBalanceRequestDetails(
                            widget.balanceRequest?.id ?? -1)),
              )),
    );

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(MostUsedButton(
        buttonText: 'حفظ',
        buttonIcon: Icons.save,
        onTap: () async {
          if (_balanceRequestDetailsFormKey.currentState!.validate()) {
            _balanceRequestDetailsFormKey.currentState?.save();

            balanceRequestsDetailsController?.updateAmount(
                widget.balanceRequest?.userId ?? -1, params);
          }
        }));

    return const GlobalInterface();
  }
}
