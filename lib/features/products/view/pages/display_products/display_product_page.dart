import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/style/constraint_style_features.dart';
import '../../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../../presentation/view/global_interface.dart';
import '../../../controller/received_images_controller.dart';
import '../../../model/models/product_model.dart';
import '../../widgets/product_display_widget.dart';

class DisplayProductPage extends StatefulWidget {
  final ProductModel? productModel;

  const DisplayProductPage({super.key, this.productModel});

  @override
  State<DisplayProductPage> createState() => _DisplayProductPageState();
}

class _DisplayProductPageState extends State<DisplayProductPage> {
  final ReceivedImagesController receivedImagesController =
      Get.put(ReceivedImagesController());

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
      description: widget.productModel?.description ?? "",
      productName: widget.productModel?.name ?? "",
      barcode: widget.productModel?.barcode ?? "",
      price: widget.productModel?.price ?? 0,
      quantity: widget.productModel?.quantity ?? 0,
      minimumQuantity: widget.productModel?.minimumQuantity ?? 0,
    ));

    return const GlobalInterface();
  }
}
