import 'package:belahododdashboard/features/products/controller/products_controller.dart';
import 'package:belahododdashboard/features/products/model/models/image_file_model.dart';
import 'package:belahododdashboard/features/products/model/models/product_model.dart';
import 'package:belahododdashboard/features/products/model/models/quran_model.dart';
import 'package:belahododdashboard/features/products/model/params/product_params.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../core/components/custom_dropdown_list.dart';
import '../../../../../core/components/most_used_button.dart';
import '../../../../../core/components/used_filled.dart';
import '../../../../../core/constants/style/constraint_style_features.dart';
import '../../../../../core/constants/style/text_style_features.dart';
import '../../../../../core/constants/urls.dart';
import '../../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../../presentation/view/global_interface.dart';
import '../../../../subsections/controller/dropdown_controller.dart';
import '../../../../subsections/controller/subsection_controller.dart';
import '../../../controller/file_upload_controller.dart';

class ModifyQuranScreen extends StatefulWidget {
  final int? sectionId;
  final ProductModel? product;

  const ModifyQuranScreen({super.key, this.product, this.sectionId});

  @override
  State<ModifyQuranScreen> createState() => _ModifyQuranScreenState();
}

class _ModifyQuranScreenState extends State<ModifyQuranScreen> {
  int? subsectionsNumber = 0;

  final ProductsController? productsController = Get.find<ProductsController>();
  final DropdownController? dropdownController = Get.find<DropdownController>();

  final FileUploadController fileUploadController =
      Get.put(FileUploadController());
  final _quranFormKey = GlobalKey<FormState>();
  ProductParams params = ProductParams();
  TextEditingController name = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController traderPrice = TextEditingController();

  TextEditingController quantity = TextEditingController();
  TextEditingController minimumQuantity = TextEditingController();
  TextEditingController publisher = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController numberOfPages = TextEditingController();
  TextEditingController printType = TextEditingController();
  TextEditingController specifications = TextEditingController();
  final SubsectionsController? subsectionsController =
      Get.find<SubsectionsController>();

  @override
  void initState() {
    params.quran = QuranModel();

    if (widget.product != null) {
      name.text = widget.product?.name ?? "";
      barcode.text = widget.product?.barcode ?? "";
      description.text = widget.product?.description ?? "";
      price.text = widget.product?.price.toString() ?? "";
      traderPrice.text = widget.product?.traderPrice.toString() ?? "";

      quantity.text = widget.product?.quantity.toString() ?? "";
      minimumQuantity.text = widget.product?.minimumQuantity.toString() ?? "";
      publisher.text = widget.product?.quran?.publisher.toString() ?? "";
      size.text = widget.product?.quran?.size.toString() ?? "";
      numberOfPages.text = widget.product?.quran?.numOfPages.toString() ?? "";
      printType.text = widget.product?.quran?.printType.toString() ?? "";
      specifications.text =
          widget.product?.quran?.specifications.toString() ?? "";
    }
    subsectionsController?.getSubsections(widget.sectionId, true);

    super.initState();
  }

  void _selectFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      fileUploadController.addFile(
          result.files.first.bytes!, result.files.first.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalInterfaceController globalInterfaceController =
        Get.put(GlobalInterfaceController());
    globalInterfaceController.removeExtraWidgets();
    globalInterfaceController.addExtraWidget(
      Center(
        child: Text(
          widget.product != null ? 'تعديل مصحف' : 'إضافة مصحف',
          style: TextStyleFeatures.headLinesTextStyle,
        ),
      ),
    );
    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );
    globalInterfaceController.addExtraWidget(Form(
      key: _quranFormKey,
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UsedFilled(
                label: 'اسم المنتج',
                controller: name,
                isMandatory: true,
                onSaved: (value) {
                  params.name = value;
                },
              ),
              UsedFilled(
                label: 'الباركود',
                controller: barcode,
                isMandatory: true,
                onSaved: (value) {
                  params.barcode = value;
                },
              ),
              UsedFilled(
                label: 'الوصف',
                controller: description,
                isMandatory: true,
                onSaved: (value) {
                  params.description = value;
                },
              ),
              UsedFilled(
                label: 'السعر',
                controller: price,
                isMandatory: true,
                onSaved: (value) {
                  params.price = value;
                },
              ),
              UsedFilled(
                label: 'الكمية',
                controller: quantity,
                isMandatory: true,
                onSaved: (value) {
                  params.quantity = value;
                },
              ),
              UsedFilled(
                label: 'السعر للتاجر',
                controller: traderPrice,
                isMandatory: true,
                onSaved: (value) {
                  params.traderPrice = value;
                },
              ),
              UsedFilled(
                label: 'الحد الأدنى للكمية',
                controller: minimumQuantity,
                isMandatory: true,
                onSaved: (value) {
                  params.minimumQuantity = value;
                },
              ),
              UsedFilled(
                label: 'الناشر',
                controller: publisher,
                isMandatory: true,
                onSaved: (value) {
                  params.quran?.publisher = value;
                },
              ),
              UsedFilled(
                label: 'القياس',
                controller: size,
                isMandatory: true,
                onSaved: (value) {
                  params.quran?.size = value;
                },
              ),
              UsedFilled(
                label: 'عدد الصفحات',
                controller: numberOfPages,
                isMandatory: true,
                onSaved: (value) {
                  params.quran?.numOfPages = value;
                },
              ),
              UsedFilled(
                label: 'المواصفات',
                controller: specifications,
                isMandatory: true,
                onSaved: (value) {
                  params.quran?.specifications = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(.5),
                child: subsectionsController!.obx((state) {
                  var subsections = state ?? [];
                  var itemNames = subsections.map((item) => item.name).toList();
                  var selectedItem =
                      dropdownController?.selectedStringItems.value;

                  // Ensure selectedItem is in the list
                  if (selectedItem != null &&
                      !itemNames.contains(selectedItem)) {
                    selectedItem = null; // Reset if invalid
                  }

                  return CustomDropdownList(
                    hint: "القسم الفرعي",
                    label: "القسم الفرعي",
                    onChanged: (value) {
                      // Update the selected string
                      dropdownController?.sChange(value);

                      // Find and update the corresponding ID
                      var selectedSubSection =
                          subsections.firstWhere((item) => item.name == value);
                      dropdownController
                          ?.setSubSectionId(selectedSubSection.id);
                      subsectionsNumber = subsections.length;
                    },
                    sItems: List<DropdownMenuItem<String>>.generate(
                      subsections.length,
                      (index) {
                        return DropdownMenuItem<String>(
                          value: subsections[index].name,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              '${subsections[index].name}',
                              style: TextStyle(fontSize: 18.px),
                            ),
                          ),
                        );
                      },
                    ),
                    selectedItem: selectedItem,
                  );
                }),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                children: [
                  Text(
                    "صورة المنتج",
                    style: TextStyleFeatures.generalTextStyle,
                    textDirection: TextDirection.rtl,
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
                    () => fileUploadController.images.isEmpty &&
                            widget.product != null
                        ? Expanded(
                            child: ListView(
                            shrinkWrap: true,
                            children: [
                              SizedBox(
                                  child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.product?.images != null
                                      ? Image.network(
                                          Urls.imageUrl +
                                              widget.product!.images!
                                                  .replaceAll('[', "")
                                                  .replaceAll(']', '')
                                                  .replaceAll('"', "")
                                                  .replaceAll("\\", ""),
                                          height: 10.w,
                                          fit: BoxFit.cover,
                                        )
                                      : const Text("")
                                ],
                              ))
                            ],
                          ))
                        : Expanded(
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
                                    Text(fileUploadController
                                        .images[index].fileName)
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
        onTap: () async {
          _quranFormKey.currentState?.save();
          if (_quranFormKey.currentState!.validate() &&
              fileUploadController.images.isNotEmpty) {
            _quranFormKey.currentState?.save();

            if (widget.product != null) {
              if (subsectionsNumber != 0) {
                params.subSectionId =
                    dropdownController?.selectedSubSectionId.value.toString();
              } else {
                params.subSectionId = null;
              }
              params.sectionId = widget.sectionId.toString();
              List<ImageFileModel> images = [];
              for (int i = 0; i < fileUploadController.images.length; i++) {
                images.add(fileUploadController.images[i]);
              }
              productsController?.updateProduct(widget.sectionId ?? 0,
                  widget.product?.id ?? 0, params, images);
            } else {
              if (subsectionsNumber != 0) {
                params.subSectionId =
                    dropdownController?.selectedSubSectionId.value.toString();
              } else {
                params.subSectionId = null;
              }
              params.sectionId = widget.sectionId.toString();
              List<ImageFileModel> images = [];
              for (int i = 0; i < fileUploadController.images.length; i++) {
                images.add(fileUploadController.images[i]);
              }

              bool? isClear =
                  await productsController?.addProduct(params, images);
              if (isClear ?? false) {
                fileUploadController.clear();
              }
            }
          }
          fileUploadController.clear();
        },
      ),
    );
    return const GlobalInterface();
  }
}
