import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/constants/style/constraint_style_features.dart';
import '../../../../../presentation/controllers/global_interface_controller.dart';
import '../../../../../presentation/view/global_interface.dart';
import '../../../controller/received_images_controller.dart';
import '../../../model/models/product_model.dart';
import '../../widgets/product_display_widget.dart';

class DisplayStationaryPage extends StatefulWidget {
  final ProductModel? productModel;

  const DisplayStationaryPage({super.key, this.productModel});

  @override
  State<DisplayStationaryPage> createState() => _DisplayStationaryPageState();
}

class _DisplayStationaryPageState extends State<DisplayStationaryPage> {
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
        'الأهداف': widget.productModel?.stationery?.goals,
        'المواد المصنعة':widget.productModel?.stationery?.materials,
        'المصنّع':widget.productModel?.stationery?.manufacturer,
        'خصائص المنتج':widget.productModel?.stationery?.specifications,
      },
    ));

    return const GlobalInterface();
  }
}
