import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/style/constraint_style_features.dart';
import '../../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../../presentation/view/global_interface.dart';
import '../../../controller/received_images_controller.dart';
import '../../../model/models/product_model.dart';
import '../../widgets/product_display_widget.dart';

class DisplayBookPage extends StatefulWidget {
  final ProductModel? productModel;
  const DisplayBookPage({super.key,  this.productModel});

  @override
  State<DisplayBookPage> createState() => _DisplayBookPageState();
}

class _DisplayBookPageState extends State<DisplayBookPage> {
  final ReceivedImagesController receivedImagesController = Get.put(ReceivedImagesController());

  @override
  void initState() {
    super.initState();
    // Parse images when the widget is initialized
    if (widget.productModel?.images != null) {
      receivedImagesController.parseImages(widget.productModel!.images!);
    }
  }
  @override
  Widget build(BuildContext context) {
    final GlobalInterfaceController globalInterfaceController =
    Get.put(GlobalInterfaceController());

    globalInterfaceController.removeExtraWidgets();

    globalInterfaceController.addExtraWidget(
      const SizedBox(height: ConstraintStyleFeatures.spaceBetweenElements),
    );

    globalInterfaceController.addExtraWidget(ProductDisplayWidget(
      images: receivedImagesController.imagePaths.toList(),
      description: widget.productModel?.description??"",
      productName: widget.productModel?.name??"",
      barcode: widget.productModel?.barcode??"",
      price: widget.productModel?.price??0,
      quantity: widget.productModel?.quantity??0,
      minimumQuantity: widget.productModel?.minimumQuantity??0,
      additionalSpecifications:  {
        'المؤلف': widget.productModel?.book?.author,
        'المترجم': widget.productModel?.book?.translator,
        'الأبعاد': widget.productModel?.book?.dimensions,
        'عدد الصفحات' : widget.productModel?.book?.numOfPages,
        'نوع الطباعة':widget.productModel?.book?.printType,
        'العمر المستهدف':widget.productModel?.book?.targetAge,
      },
    ));

    return const GlobalInterface();
  }
}
