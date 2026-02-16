import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/components/retry_widget.dart';
import '../../../../../core/constants/style/constraint_style_features.dart';
import '../../../../../core/constants/style/text_style_features.dart';
import '../../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../../presentation/view/global_interface.dart';
import '../../controller/balance_requests_controller.dart';
import '../widgets/balance_request_widget.dart';

class BalanceRequestsScreen extends StatefulWidget {
  const BalanceRequestsScreen({super.key});

  @override
  State<BalanceRequestsScreen> createState() => _BalanceRequestsScreenState();
}

class _BalanceRequestsScreenState extends State<BalanceRequestsScreen> {
  final BalanceRequestsController? balanceController =
      Get.find<BalanceRequestsController>();

  @override
  void initState() {
    balanceController?.getBalanceRequests(true);
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
          'طلبات تعبئة المحفظة',
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(
      Expanded(
        child: balanceController!.obx(
            (state) => GridView.builder(
                  padding:
                      EdgeInsets.all(ConstraintStyleFeatures.gridsPadding()),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: state?.length ?? 0,
                  itemBuilder: (context, index) {
                    return BalanceRequestWidget(
                      balanceRequest: state![index],
                    );
                  },
                ),
            onLoading: const Center(child: CircularProgressIndicator()),
            onEmpty: Center(
              child: RetryWidget(
                  error: "لا يوجد نتائج",
                  func: () => balanceController?.getBalanceRequests(true)),
            ),
            onError: (error) => Center(
                  child: RetryWidget(
                      error: error!,
                      func: () => balanceController?.getBalanceRequests(true)),
                )),
      ),
    );

    return const GlobalInterface();
  }
}
