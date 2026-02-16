import 'package:belahododdashboard/features/orders/controller/delivery_method_dropdown_controller.dart';
import 'package:belahododdashboard/features/orders/controller/normal_orders_controller.dart';
import 'package:belahododdashboard/features/orders/controller/order_details_controller.dart';
import 'package:belahododdashboard/features/orders/model/models/normal_order_model.dart';
import 'package:belahododdashboard/features/orders/view/pages/pending_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/components/retry_widget.dart';
import '../../../../core/constants/style/color_style_features.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';
import '../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../core/components/most_used_button.dart';
import '../../../../presentation/view/global_interface.dart';
import '../../controller/status_dropdown_controller.dart';
import '../../model/params/change_status_params.dart';
import '../../model/params/processing_order_params.dart';
import '../widgets/label_widget.dart';

class ModifyDeliveryOrderScreen extends StatefulWidget {
  final NormalOrderModel? order;
  final int pageIndex;

  const ModifyDeliveryOrderScreen(
      {super.key, this.order, required this.pageIndex});

  @override
  State<ModifyDeliveryOrderScreen> createState() =>
      _ModifyDeliveryOrderScreenState();
}

class _ModifyDeliveryOrderScreenState extends State<ModifyDeliveryOrderScreen> {
  final NormalOrdersController? normalOrdersController =
      Get.find<NormalOrdersController>();
  final OrderDetailsController? orderDetailsController =
      Get.find<OrderDetailsController>();
  final StatusDropdownController? statusDropdownController =
      Get.find<StatusDropdownController>();
  final DeliveryMethodDropdownController? deliveryMethodDropdownController =
      Get.find<DeliveryMethodDropdownController>();
  final _processingOrderFromKey = GlobalKey<FormState>();
  ProcessingOrderParams params = ProcessingOrderParams();
  TextEditingController deliveryMethod = TextEditingController();
  TextStyleFeatures textStyleFeatures = TextStyleFeatures();
  TextEditingController deliveryCost = TextEditingController();
  ChangeStatusParams params1 = ChangeStatusParams();

  @override
  void initState() {
    orderDetailsController?.getOrderDetails(widget.order?.id ?? 0);
    statusDropdownController?.change("قيد المعالجة");

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
          "تعديل طلب",
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );
    globalInterfaceController.addExtraWidget(
      orderDetailsController!.obx(
          (state) => Form(
              key: _processingOrderFromKey,
              child: Expanded(
                child: LayoutBuilder(builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: constraint.maxWidth * 0.3,
                            height: constraint.maxHeight * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.px),
                              color: ColorStyleFeatures.mostUsedButtonColor,
                            ),
                            child: Center(
                              child: Text(
                                "تفاصييل الطلب رقم ${state?.id}",
                                style: textStyleFeatures
                                    .generalTextStyleWithConstraints1(
                                        constraint),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          LabelWidget(
                            label: "رقم الهاتف:",
                            value: state?.phoneNumber ?? "",
                          ),
                          LabelWidget(
                            label: "تاريخ الطلب:",
                            value: DateFormat('yyyy-MM-dd kk:mm')
                                .format(state!.orderDate!),
                          ),
                          LabelWidget(
                            label: "الكلفة الاجمالية:",
                            value: state.totalCost.toString(),
                          ),
                          LabelWidget(
                            label: "اجمالي عدد المنتجات:",
                            value: state.totalNumberOfProducts.toString(),
                          ),
                          LabelWidget(
                            label: "حالة الطلب:",
                            value: state.orderStatus ?? "",
                          ),
                          LabelWidget(
                            label: "اسم صاحب الطلب:",
                            value: state.username ?? "",
                          ),
                          LabelWidget(
                            label: "العنوان:",
                            value: state.address ?? "",
                          ),
                          LabelWidget(
                            label: "ملاحظات من الزبون:",
                            value: state.notes ?? "",
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            "تفاصيل الطلب:",
                            style: TextStyleFeatures.generalTextStyle,
                          ),
                          Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.orderDetails?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        LabelWidget(
                                          label: "الاسم:",
                                          value:
                                              state.orderDetails?[index].name ??
                                                  "",
                                        ),
                                        LabelWidget(
                                          label: "الكمية:",
                                          value: state
                                                  .orderDetails?[index].quantity
                                                  .toString() ??
                                              "",
                                        ),
                                        LabelWidget(
                                          label: "سعر القطعة:",
                                          value: state.orderDetails?[index]
                                                  .unitPrice
                                                  .toString() ??
                                              "",
                                        ),
                                        LabelWidget(
                                          label: "الإجمالي:",
                                          value: state.orderDetails?[index]
                                                  .totalPrice
                                                  .toString() ??
                                              "",
                                        ),
                                      ],
                                    );
                                  }),
                            ],
                          ),
                          Obx(() => Row(
                                children: [
                                  Text(
                                    "حالة الطلب",
                                    style: TextStyleFeatures.generalTextStyle,
                                  ),
                                  const SizedBox(width: 25),
                                  Container(
                                    height: 8.h,
                                    width: 100.w * 100.h * 0.0004,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorStyleFeatures
                                            .headLinesTextColor,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: DropdownButton<String>(
                                      hint: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          "حالة الطلب",
                                          style: TextStyle(fontSize: 14.px),
                                        ),
                                      ),
                                      underline: Container(),
                                      value: statusDropdownController
                                          ?.selectedItem.value,
                                      onChanged: (String? selectedItem) {
                                        statusDropdownController
                                            ?.change(selectedItem ?? "");
                                      },
                                      items: [
                                        DropdownMenuItem<String>(
                                          value: "في طريقه إليك",
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Text(
                                              "في طريقه إليك",
                                              style: TextStyle(fontSize: 18.px),
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: "قيد المعالجة",
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Text(
                                              "قيد المعالجة",
                                              style: TextStyle(fontSize: 18.px),
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: "تم تنفيذه",
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Text(
                                              "تم تنفيذه",
                                              style: TextStyle(fontSize: 18.px),
                                            ),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: "تم إلغاؤه",
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Text(
                                              "تم إلغاؤه",
                                              style: TextStyle(fontSize: 18.px),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                }),
              )),
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: Center(
            child: RetryWidget(
                error: "لا يوجد نتائج",
                func: () => orderDetailsController
                    ?.getOrderDetails(widget.order?.id ?? 0)),
          ),
          onError: (error) => Center(
                child: RetryWidget(
                    error: error!,
                    func: () => orderDetailsController
                        ?.getOrderDetails(widget.order?.id ?? 0)),
              )),
    );

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(orderDetailsController!.obx(
      (state) => MostUsedButton(
        buttonText: 'حفظ',
        buttonIcon: Icons.save,
        onTap: () async {
          params1.status = statusDropdownController?.selectedItem.value;
          bool? isSuccess1 = await normalOrdersController?.changeOrderStatus(
              widget.order?.id ?? 0, params1);
          if (isSuccess1 ?? false) {
            Get.off(() => PendingOrdersScreen(
                  initialPage: widget.pageIndex,
                ));
          }
        },
      ),
      onLoading: const SizedBox(),
      onEmpty: const SizedBox(),
      onError: (error) => const SizedBox(),
    ));
    return const GlobalInterface();
  }
}
