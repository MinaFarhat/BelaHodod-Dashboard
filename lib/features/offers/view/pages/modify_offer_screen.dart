// ignore_for_file: use_build_context_synchronously

import 'package:belahododdashboard/features/offers/controller/offers_controller.dart';
import 'package:belahododdashboard/features/offers/model/models/offer_model.dart';
import 'package:belahododdashboard/features/offers/model/params/offer_product_params.dart';
import 'package:belahododdashboard/features/offers/model/params/offer_params.dart';
import 'package:belahododdashboard/features/products/controller/products_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/components/custom_dropdown_list.dart';
import '../../../../core/components/retry_widget.dart';
import '../../../../core/components/used_filled.dart';
import '../../../../core/constants/style/constraint_style_features.dart';
import '../../../../core/constants/style/text_style_features.dart';
import '../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../core/components/most_used_button.dart';
import '../../../../presentation/view/global_interface.dart';
import '../../../products/controller/file_upload_controller.dart';
import '../../../products/model/models/image_file_model.dart';
import '../../controller/offer_products_controller.dart';

class ModifyOfferScreen extends StatefulWidget {
  final OfferModel? offer;

  const ModifyOfferScreen({super.key, this.offer});

  @override
  State<ModifyOfferScreen> createState() => _ModifyOfferScreenState();
}

class _ModifyOfferScreenState extends State<ModifyOfferScreen> {
  final OffersController? offersController = Get.find<OffersController>();
  final ProductsController? productsController = Get.find<ProductsController>();
  final OfferProductsController? offerProductController =
      Get.find<OfferProductsController>();
  final _offerFormKey = GlobalKey<FormState>();
  OfferParams params = OfferParams();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController discountRate = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  final FileUploadController fileUploadController =
      Get.put(FileUploadController());

  @override
  void initState() {
    params.offerProducts = [];
    offerProductController?.clear();

    productsController?.searchProductByName("");
    if (widget.offer != null) {
      name.text = widget.offer?.name ?? "";
      description.text = widget.offer?.description ?? "";
      discountRate.text = (widget.offer?.discountRate ?? 0).toString();
    }

    super.initState();
  }

  DateFormat format = DateFormat("yyyy-MM-dd hh:mm:ss");

  DateTime? selectedDateTime;

  Future<void> _selectDateTime(
      BuildContext context, TextEditingController text) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? now),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
              DateTime.now().second);

          text.text = DateFormat('yyyy-MM-dd hh:mm:ss')
              .format(selectedDateTime!.toLocal());
        });
      }
    }
  }

  void _selectFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      fileUploadController.addFile(
          result.files.first.bytes!, result.files.first.name);
    }
  }

  void _showDialog(BuildContext context, value) {
    TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("كمية المنتج"),
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(
                hintText: "أدخل الكمية", hintStyle: TextStyle(fontSize: 20)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                value.quantity = int.parse(textController.text);
                params.offerProducts?.add(value);
                offerProductController?.addOfferProducts(value);
                Navigator.of(context).pop();
              },
              child: const Text("تأكيد"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("إلغاء"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalInterfaceController globalInterfaceController =
        Get.put(GlobalInterfaceController());
    globalInterfaceController.removeExtraWidgets();
    globalInterfaceController.addExtraWidget(
      Center(
        child: Text(
          widget.offer != null ? 'تعديل عرض' : 'إضافة عرض جديد',
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );
    globalInterfaceController.addExtraWidget(Form(
      key: _offerFormKey,
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UsedFilled(
                label: 'اسم العرض',
                controller: name,
                isMandatory: true,
                onSaved: (value) {
                  params.name = value;
                },
              ),
              UsedFilled(
                label: 'وصف العرض',
                controller: description,
                isMandatory: true,
                onSaved: (value) {
                  params.description = value;
                },
              ),
              UsedFilled(
                label: 'الحسم',
                controller: discountRate,
                isMandatory: true,
                onSaved: (value) {
                  params.discountRate = int.parse(value);
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: UsedFilled(
                      label: 'تاريخ البدء',
                      controller: startDate,
                      isMandatory: true,
                      enabled: false,
                      validator: (value) {
                        if (startDate.text == "") {
                          return 'ادخل قيمة';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        params.startDate = DateFormat('yyyy-MM-dd hh:mm:ss')
                            .parse(startDate.text);
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _selectDateTime(context, startDate);
                    },
                    child: const Text('اختر التاريخ'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: UsedFilled(
                      label: 'تاريخ النهاية',
                      controller: endDate,
                      isMandatory: true,
                      enabled: false,
                      validator: (value) {
                        if (startDate.text == "") {
                          return 'ادخل قيمة';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        params.endDate = DateFormat('yyyy-MM-dd hh:mm:ss')
                            .parse(endDate.text);
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _selectDateTime(context, endDate);
                    },
                    child: const Text('اختر التاريخ'),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              productsController!.obx(
                  (state) => CustomDropdownList(
                        hint: "المنتجات",
                        label: "إضافة منتج",
                        onChanged: (value) {
                          setState(() {
                            if (params.offerProducts?.indexWhere(
                                    (x) => x.productId == value.productId) ==
                                -1) {
                              _showDialog(context, value);
                            }
                          });
                        },
                        dItems:
                            List<DropdownMenuItem<OfferProductParams>>.generate(
                          state!.length,
                          (index) {
                            return DropdownMenuItem<OfferProductParams>(
                              value: OfferProductParams(
                                  productId: state[index].id.toString(),
                                  quantity: state[index].quantity,
                                  name: state[index].name),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  '${state[index].name}',
                                  style: TextStyle(fontSize: 18.px),
                                ),
                              ),
                            );
                          },
                        ),
                        selectedItem: null,
                      ),
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onEmpty: Center(
                    child: RetryWidget(
                        error: "لا يوجد نتائج",
                        func: () =>
                            productsController?.searchProductByName("")),
                  ),
                  onError: (error) => Center(
                        child: RetryWidget(
                            error: error!,
                            func: () =>
                                productsController?.searchProductByName("")),
                      )),
              SizedBox(height: 2.h),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: offerProductController?.offerProducts.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Text(
                          offerProductController?.offerProducts[index].name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const Text(":"),
                        Text(
                          offerProductController?.offerProducts[index].quantity
                                  .toString() ??
                              "",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                children: [
                  Text(
                    "صورة العرض",
                    style: TextStyleFeatures.generalTextStyle,
                    // textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(width: 25),
                  GestureDetector(
                      onTap: () {
                        _selectFile();
                      },
                      child: Container(
                          width: 15.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: SizedBox(
                              width: 13.w,
                              height: 10.w,
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                  size: 33,
                                ),
                              ),
                            ),
                          ))),
                  Obx(
                    () => Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: fileUploadController.images.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.memory(
                                fileUploadController.images[index].image,
                                height: 10.w,
                                fit: BoxFit.cover,
                              ),
                              Text(fileUploadController.images[index].fileName)
                            ],
                          ));
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(
      MostUsedButton(
        buttonText: 'حفظ',
        buttonIcon: Icons.save,
        onTap: () {
          if (_offerFormKey.currentState!.validate()) {
            _offerFormKey.currentState?.save();

            if (widget.offer != null) {
              List<ImageFileModel> images = [];
              for (int i = 0; i < fileUploadController.images.length; i++) {
                images.add(fileUploadController.images[i]);
              }
              offersController?.updateOffer(
                  widget.offer?.id ?? 0, params, images, params.offerProducts!);
            } else {
              List<ImageFileModel> images = [];
              for (int i = 0; i < fileUploadController.images.length; i++) {
                images.add(fileUploadController.images[i]);
              }
              offersController?.addOffer(params, images, params.offerProducts!);
            }
          }
          fileUploadController.clear();
        },
      ),
    );
    return const GlobalInterface();
  }
}
