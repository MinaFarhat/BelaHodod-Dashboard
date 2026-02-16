import 'package:belahododdashboard/features/orders/controller/normal_orders_controller.dart';
import 'package:belahododdashboard/features/orders/view/widgets/normal_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/components/retry_widget.dart';
import '../../../../../core/constants/style/constraint_style_features.dart';
import '../../../../../core/constants/style/text_style_features.dart';
import '../../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../../presentation/view/global_interface.dart';
import 'modify_done_order_screen.dart';

class DoneOrdersScreen extends StatefulWidget {
  const DoneOrdersScreen({super.key});

  @override
  State<DoneOrdersScreen> createState() => _DoneOrdersScreenState();
}

class _DoneOrdersScreenState extends State<DoneOrdersScreen> {
  final NormalOrdersController? normalOrdersController =
      Get.find<NormalOrdersController>();

  @override
  void initState() {
    normalOrdersController?.getDoneOrders();
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
          'الطلبات اللتي تم تنفيذها',
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(
      Expanded(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                return Expanded(
                  child: normalOrdersController!.obx(
                      (state) => GridView.builder(
                            padding: EdgeInsets.all(
                                ConstraintStyleFeatures.gridsPadding()),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    // Number of columns
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: 220.px,
                                    childAspectRatio: 1),
                            itemCount: state?.length ?? 0,
                            itemBuilder: (context, index) {
                              return NormalOrderWidget(
                                constraints: constraints,
                                order: state![index],
                                onTap: () {
                                  Get.to(() => ModifyDoneOrderScreen(
                                        pageIndex: 1,
                                        order: state[index],
                                      ));
                                },
                              );
                            },
                          ),
                      onLoading:
                          const Center(child: CircularProgressIndicator()),
                      onEmpty: Center(
                        child: RetryWidget(
                            error: "لا يوجد نتائج",
                            func: () =>
                                normalOrdersController?.getDeliveryOrders()),
                      ),
                      onError: (error) => Center(
                            child: RetryWidget(
                                error: error!,
                                func: () => normalOrdersController
                                    ?.getDeliveryOrders()),
                          )),
                );
              }),
            ),
          ],
        ),
      ),
    );

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    return const GlobalInterface();
  }
}
